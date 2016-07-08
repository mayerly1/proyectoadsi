<?php $this->load->view("partial/header"); ?>
<div id="edit_sale_wrapper">
<?php 
if ($success)
{
?>
	<h2><?php echo $this->lang->line('sales_delete_successful'); ?></h2>
<?php	
}
else
{
?>
	<h2><?php echo $this->lang->line('sales_delete_unsuccessful'); ?></h2>
<?php
}
?>
</div>
<?php $this->load->view("partial/footer"); ?>