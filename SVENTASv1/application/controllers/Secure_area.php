<?php
class Secure_area extends CI_Controller 
{
	/*
	Los controladores que se consideran seguros extienden Secured_area, opcionalmente, un $ module_id se puede configurar para comprobar también si un usuario puede acceder a un módulo particular en el sistema.
	*/
	function __construct($module_id=null)
	{
		parent::__construct();	
		$this->load->model('Employee');
		if(!$this->Employee->is_logged_in())
		{
			redirect('login');
		}
		
		if(!$this->Employee->has_permission($module_id,$this->Employee->get_logged_in_employee_info()->person_id))
		{
			redirect('no_access/'.$module_id);
		}
		
		//cargar datos globales
		$logged_in_employee_info=$this->Employee->get_logged_in_employee_info();
		$data['allowed_modules']=$this->Module->get_allowed_modules($logged_in_employee_info->person_id);
		$data['user_info']=$logged_in_employee_info;
		$this->load->vars($data);
	}
}
?>