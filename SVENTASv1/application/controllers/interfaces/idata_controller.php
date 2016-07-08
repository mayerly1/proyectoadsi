<?php
/*
Esta interfaz se implementa mediante cualquier controlador que realiza un seguimiento de las personas , tales
ya que los clientes y empleados .
*/
interface iData_controller
{
	public function index();
	public function search();
	public function suggest();
	public function get_row();
	public function view($data_item_id=-1);
	public function save($data_item_id=-1);
	public function delete();
	public function get_form_width();
}
?>