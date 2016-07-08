<?php
class Receiving_lib
{
	var $CI;

  	function __construct()
	{
		$this->CI =& get_instance();
	}

	function get_cart()
	{
		if(!$this->CI->session->userdata('cartRecv'))
			$this->set_cart(array());

		return $this->CI->session->userdata('cartRecv');
	}

	function set_cart($cart_data)
	{
		$this->CI->session->set_userdata('cartRecv',$cart_data);
	}

	function get_supplier()
	{
		if(!$this->CI->session->userdata('supplier'))
			$this->set_supplier(-1);

		return $this->CI->session->userdata('supplier');
	}

	function set_supplier($supplier_id)
	{
		$this->CI->session->set_userdata('supplier',$supplier_id);
	}

	function get_mode()
	{
		if(!$this->CI->session->userdata('recv_mode'))
			$this->set_mode('receive');

		return $this->CI->session->userdata('recv_mode');
	}

	function set_mode($mode)
	{
		$this->CI->session->set_userdata('recv_mode',$mode);
	}

	function add_item($item_id,$quantity=1,$discount=0,$price=null,$description=null)
	{
		//asegura de que existe el producto en la base de datos.
		if(!$this->CI->Item->exists($item_id))
		{
			//tratar de conseguir un elemento identificador dado numero producto
			$item_id = $this->CI->Item->get_item_id($item_id);

			if(!$item_id)
				return false;
		}

		//trae los elementos de la cesta hasta el momento.
		$items = $this->get_cart();

         /* Tenemos que recorrer todos los elementos de la cesta.
         Si el artículo ya está ahí.
         También tenemos que obtener la siguiente tecla que vamos a utilizar en caso tenemos que añadir el producto a la lista. Puesto que los artículos se pueden eliminar, no podemos usar un recuento. utilizamos la tecla alt + 1.*/

        $maxkey=0;                       //nota más alta hasta el momento
        $itemalreadyinsale=FALSE;        //No se encontró el producto todavía.
		$insertkey=0;                    //se usapara hacer una nueva entrada.
		$updatekey=0;                    //Se utiliza para actualizar (cantidad)

		foreach ($items as $item)
		{
            
            //se ha preparado el bucle maxkey
			// Además, tenemos almacenada la llave en el propio elemento para que podamos comparar.

			if($maxkey <= $item['line'])
			{
				$maxkey = $item['line'];
			}

			if($item['item_id']==$item_id)
			{
				$itemalreadyinsale=TRUE;
				$updatekey=$item['line'];
			}
		}

		$insertkey=$maxkey+1;

		//los registros se identifican por $insertkey e item_id es simplemente otro campo.
		$item = array(($insertkey)=>
		array(
			'item_id'=>$item_id,
			'line'=>$insertkey,
			'name'=>$this->CI->Item->get_info($item_id)->name,
			'description'=>$description!=null ? $description: $this->CI->Item->get_info($item_id)->description,
			'quantity'=>$quantity,
            'discount'=>$discount,
			'price'=>$price!=null ? $price: $this->CI->Item->get_info($item_id)->cost_price
			)
		);

		//Objeto ya existe
		if($itemalreadyinsale)
		{
			$items[$updatekey]['quantity']+=$quantity;
		}
		else
		{
			//añadir al array existente
			$items+=$item;
		}

		$this->set_cart($items);
		return true;

	}

	function edit_item($line,$description,$quantity,$discount,$price)
	{
		$items = $this->get_cart();
		if(isset($items[$line]))
		{
			$items[$line]['description'] = $description;
			$items[$line]['quantity'] = $quantity;
			$items[$line]['discount'] = $discount;
			$items[$line]['price'] = $price;
			$this->set_cart($items);
		}

		return false;
	}

	function is_valid_receipt($receipt_receiving_id)
	{
		//RECV #
		$pieces = explode(' ',$receipt_receiving_id);

		if(count($pieces)==2)
		{
			return $this->CI->Receiving->exists($pieces[1]);
		}

		return false;
	}
	
	
	function return_entire_receiving($receipt_receiving_id)
	{
		//FRA #
		$pieces = explode(' ',$receipt_receiving_id);
		$receiving_id = $pieces[1];

		$this->empty_cart();
		$this->delete_supplier();

		foreach($this->CI->Receiving->get_receiving_items($receiving_id)->result() as $row)
		{
			$this->add_item($row->item_id,-$row->quantity_purchased,$row->discount_percent,$row->item_unit_price,$row->description);
		}
		$this->set_supplier($this->CI->Receiving->get_supplier($receiving_id)->person_id);
	}
	
	
	function copy_entire_receiving($receiving_id)
	{
		$this->empty_cart();
		$this->delete_supplier();

		foreach($this->CI->Receiving->get_receiving_items($receiving_id)->result() as $row)
		{
			$this->add_item($row->item_id,$row->quantity_purchased,$row->discount_percent,$row->item_unit_price,$row->description);
		}
		$this->set_supplier($this->CI->Receiving->get_supplier($receiving_id)->person_id);

	}

	function delete_item($line)
	{
		$items=$this->get_cart();
		unset($items[$line]);
		$this->set_cart($items);
	}

	function empty_cart()
	{
		$this->CI->session->unset_userdata('cartRecv');
	}

	function delete_supplier()
	{
		$this->CI->session->unset_userdata('supplier');
	}

	function clear_mode()
	{
		$this->CI->session->unset_userdata('receiving_mode');
	}

	function clear_all()
	{
		$this->clear_mode();
		$this->empty_cart();
		$this->delete_supplier();
	}

	function get_total()
	{
		$total = 0;
		foreach($this->get_cart() as $item)
		{
            $total+=($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100);
		}
		
		return $total;
	}
}
?>