<?php
/*
Esta interfaz se implementa mediante cualquier controlador que realiza un seguimiento de las personas , tales
ya que los clientes y empleados .
*/
require_once("idata_controller.php");
interface iPerson_controller extends iData_controller
{
	public function mailto();
}
?>