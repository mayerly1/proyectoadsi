<?php
class Employee extends Person
{
	/*
	Determina si un person_id dado es un empleado
	*/
	function exists($person_id)
	{
		$this->db->from('employees');	
		$this->db->join('people', 'people.person_id = employees.person_id');
		$this->db->where('employees.person_id',$person_id);
		$query = $this->db->get();
		
		return ($query->num_rows()==1);
	}	
	
	/*
	retorna todos los empleados
	*/
	function get_all($limit=10000, $offset=0)
	{
		$this->db->from('employees');
		$this->db->where('deleted',0);		
		$this->db->join('people','employees.person_id=people.person_id');			
		$this->db->order_by("last_name", "asc");
		$this->db->limit($limit);
		$this->db->offset($offset);
		return $this->db->get();		
	}
	
	function count_all()
	{
		$this->db->from('employees');
		$this->db->where('deleted',0);
		return $this->db->count_all_results();
	}
	
	/*
	Obtiene información sobre un empleado en particular
	*/
	function get_info($employee_id)
	{
		$this->db->from('employees');	
		$this->db->join('people', 'people.person_id = employees.person_id');
		$this->db->where('employees.person_id',$employee_id);
		$query = $this->db->get();
		
		if($query->num_rows()==1)
		{
			return $query->row();
		}
		else
		{
			//Obtiene vacío el objeto primario de base, como employee_id si no es un empleado
			$person_obj=parent::get_info(-1);
			
			//Obtiene todos los campos de la tabla
			$fields = $this->db->list_fields('employees');
			
			//Anexar esos campos al objeto primario de base, que tenemos un objeto vacío foreach completa 
			foreach ($fields as $field)
			{
				$person_obj->$field='';
			}
			
			return $person_obj;
		}
	}
	
	/*
	Obtiene información acerca de varios empleados
	*/
	function get_multiple_info($employee_ids)
	{
		$this->db->from('employees');
		$this->db->join('people', 'people.person_id = employees.person_id');		
		$this->db->where_in('employees.person_id',$employee_ids);
		$this->db->order_by("last_name", "asc");
		return $this->db->get();		
	}
	
	/*
	Inserta o actualiza un empleado
	*/
	function saveEmployee(&$person_data, &$employee_data,&$permission_data,$employee_id=false)
	{
		$success=false;
		
		//Ejecutar estas consultas como una transacción
		$this->db->trans_start();
			
		if(parent::save($person_data,$employee_id))
		{
			if (!$employee_id or !$this->exists($employee_id))
			{
				$employee_data['person_id'] = $employee_id = $person_data['person_id'];
				$success = $this->db->insert('employees',$employee_data);
			}
			else
			{
				$this->db->where('person_id', $employee_id);
				$success = $this->db->update('employees',$employee_data);		
			}
			
			// Hemos insertado una o actualizado a un nuevo empleado, ahora le permite establecer permisos.
			if($success)
			{
				//En primer lugar permite que se vean los permisos que el empleado tiene actualmente. 
				$success=$this->db->delete('permissions', array('person_id' => $employee_id));
				
				//Ahora introduzca los nuevos permisos

				if($success)
				{
					foreach($permission_data as $allowed_module)
					{
						$success = $this->db->insert('permissions',
						array(
						'module_id'=>$allowed_module,
						'person_id'=>$employee_id));
					}
				}
			}
			
		}
		
		$this->db->trans_complete();		
		return $success;
	}
	
	/*
	elimina un empleado	
	*/
	function delete($employee_id)
	{
		$success=false;
		
		//No permita que los empleados se borren
		if($employee_id==$this->get_logged_in_employee_info()->person_id)
			return false;
		
		//Se ejecuta estas consultas como una transacción
		$this->db->trans_start();
		
		//borrar permisos
		if($this->db->delete('permissions', array('person_id' => $employee_id)))
		{	
			$this->db->where('person_id', $employee_id);
			$success = $this->db->update('employees', array('deleted' => 1));
		}
		$this->db->trans_complete();		
		return $success;
	}
	
	/*
	Elimina una lista de empleados
	*/
	function delete_list($employee_ids)
	{
		$success=false;
		
		//No permita que los empleados borren la lista
		if(in_array($this->get_logged_in_employee_info()->person_id,$employee_ids))
			return false;

		//Se ejecuta estas consultas como una transacción, queremos asegurarnos de que todo o nada 
		$this->db->trans_start();

		$this->db->where_in('person_id',$employee_ids);
		//borrar permisos
		if ($this->db->delete('permissions'))
		{
			// eliminar de tabla de empleados
			$this->db->where_in('person_id',$employee_ids);
			$success = $this->db->update('employees', array('deleted' => 1));
		}
		$this->db->trans_complete();		
		return $success;
 	}
	
	/*
	Obtener sugerencias de búsqueda para encontrar empleados
	*/
	function get_search_suggestions($search,$limit=5)
	{
		$suggestions = array();
		
		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');	
		$this->db->where("(first_name LIKE '%".$this->db->escape_like_str($search)."%' or 
		last_name LIKE '%".$this->db->escape_like_str($search)."%' or 
		CONCAT(`first_name`,' ',`last_name`) LIKE '%".$this->db->escape_like_str($search)."%') and deleted=0");
		$this->db->order_by("last_name", "asc");		
		$by_name = $this->db->get();
		foreach($by_name->result() as $row)
		{
			$suggestions[]=$row->first_name.' '.$row->last_name;		
		}
		
		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');
		$this->db->where('deleted', 0);
		$this->db->like("documento",$search);
		$this->db->order_by("documento", "asc");		
		$by_email = $this->db->get();
		foreach($by_email->result() as $row)
		{
			$suggestions[]=$row->documento;		
		}
		
		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');
		$this->db->where('deleted', 0);
		$this->db->like("email",$search);
		$this->db->order_by("email", "asc");		
		$by_email = $this->db->get();
		foreach($by_email->result() as $row)
		{
			$suggestions[]=$row->email;		
		}
		
		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');	
		$this->db->where('deleted', 0);
		$this->db->like("username",$search);
		$this->db->order_by("username", "asc");		
		$by_username = $this->db->get();
		foreach($by_username->result() as $row)
		{
			$suggestions[]=$row->username;		
		}


		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');	
		$this->db->where('deleted', 0);
		$this->db->like("phone_number",$search);
		$this->db->order_by("phone_number", "asc");		
		$by_phone = $this->db->get();
		foreach($by_phone->result() as $row)
		{
			$suggestions[]=$row->phone_number;		
		}
		
		
		//devolver sólo el límite de sugerencias 
		if(count($suggestions > $limit))
		{
			$suggestions = array_slice($suggestions, 0,$limit);
		}
		return $suggestions;
	
	}
	
	/*
	Realizar una búsqueda sobre los empleados
	*/
	function search($search)
	{
		$this->db->from('employees');
		$this->db->join('people','employees.person_id=people.person_id');		
		$this->db->where("(first_name LIKE '%".$this->db->escape_like_str($search)."%' or 
		last_name LIKE '%".$this->db->escape_like_str($search)."%' or
		documento LIKE '%".$this->db->escape_like_str($search)."%' or  
		email LIKE '%".$this->db->escape_like_str($search)."%' or 
		phone_number LIKE '%".$this->db->escape_like_str($search)."%' or 
		username LIKE '%".$this->db->escape_like_str($search)."%' or 
		CONCAT(`first_name`,' ',`last_name`) LIKE '%".$this->db->escape_like_str($search)."%') and deleted=0");		
		$this->db->order_by("last_name", "asc");
		
		return $this->db->get();	
	}
	
	/*
	Los intentos de acceder los empleados y establecer la sesión.
	*/
	function login($username, $password)
	{
		$query = $this->db->get_where('employees', array('username' => $username,'password'=>($password), 'deleted'=>0), 1);//md5 antes de corchete de $password
		if ($query->num_rows() ==1)
		{
			$row=$query->row();
			$this->session->set_userdata('person_id', $row->person_id);
			return true;
		}
		return false;
	}
	
	/*
	Cierra la sesión un usuario mediante la destrucción de todos los datos de la sesión y redirección para iniciar sesión * / cierre de sesión
	*/
	function logout()
	{
		$this->session->sess_destroy();
		redirect('login');
	}
	
	/*
	Determina si un empleado ingresa 
	*/
	function is_logged_in()
	{
		return $this->session->userdata('person_id')!=false;
	}
	
	/*
	Obtiene información sobre el empleado actualmente en sesión.
	*/
	function get_logged_in_employee_info()
	{
		if($this->is_logged_in())
		{
			return $this->get_info($this->session->userdata('person_id'));
		}
		
		return false;
	}
	
	/*
	Determinar si el empleado empleado especificada tiene acceso al módulo específico.
	*/
	function has_permission($module_id,$person_id)
	{
		// si el module_id es nulo, permitir el acceso
		if($module_id==null)
		{
			return true;
		}
		
		$query = $this->db->get_where('permissions', array('person_id' => $person_id,'module_id'=>$module_id), 1);
		return $query->num_rows() == 1;
		
		
		return false;
	}

}
?>
