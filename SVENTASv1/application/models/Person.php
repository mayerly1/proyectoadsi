<?php
class Person extends CI_Model 
{
	/*Determina si existe o no la persona dada*/
	function exists($person_id)
	{
		$this->db->from('people');	
		$this->db->where('people.person_id',$person_id);
		$query = $this->db->get();
		
		return ($query->num_rows()==1);
	}
	
	/*devuelve todas las personas*/
	function get_all($limit=10000, $offset=0)
	{
		$this->db->from('people');
		$this->db->order_by("last_name", "asc");
		$this->db->limit($limit);
		$this->db->offset($offset);
		return $this->db->get();		
	}
	
	function count_all()
	{
		$this->db->from('people');
		$this->db->where('deleted',0);
		return $this->db->count_all_results();
	}
	
	/*
	Obtiene información sobre una persona como un array.
	*/
	function get_info($person_id)
	{
		$query = $this->db->get_where('people', array('person_id' => $person_id), 1);
		
		if($query->num_rows()==1)
		{
			return $query->row();
		}
		else
		{
			//crear el objeto con propiedades vacías.
			$fields = $this->db->list_fields('people');
			$person_obj = new stdClass;
			
			foreach ($fields as $field)
			{
				$person_obj->$field='';
			}
			
			return $person_obj;
		}
	}
	
	/*
	Obtener las personas con las identificaciones específicas
	*/
	function get_multiple_info($person_ids)
	{
		$this->db->from('people');
		$this->db->where_in('person_id',$person_ids);
		$this->db->order_by("last_name", "asc");
		return $this->db->get();		
	}
	
	/*
	Inserta o actualiza una persona
	*/
	function save(&$person_data,$person_id=false)
	{		
		if (!$person_id or !$this->exists($person_id))
		{
			if ($this->db->insert('people',$person_data))
			{
				$person_data['person_id']=$this->db->insert_id();
				return true;
			}
			
			return false;
		}
		
		$this->db->where('person_id', $person_id);
		return $this->db->update('people',$person_data);
	}
	
	/*
	Eliminar una persona (en realidad no hace nada)
	*/
	function delete($person_id)
	{
		return true;; 
	}
	
	/*
	Eliminar una lista de personas (en realidad no hace nada)
	*/
	function delete_list($person_ids)
	{	
		return true;	
 	}
	
}
?>
