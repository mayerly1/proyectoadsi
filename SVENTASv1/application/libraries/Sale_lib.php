<?php
class Sale_lib
{
	var $CI;

  	function __construct()
	{
		$this->CI =& get_instance();
	}

	function get_cart()
	{
		if(!$this->CI->session->userdata('cart'))
			$this->set_cart(array());

		return $this->CI->session->userdata('cart');
	}

	function set_cart($cart_data)
	{
		$this->CI->session->set_userdata('cart',$cart_data);
	}

	//multiples pagos
	function get_payments()
	{
		if( !$this->CI->session->userdata( 'payments' ) )
			$this->set_payments( array( ) );

		return $this->CI->session->userdata('payments');
	}

	//multiples pagos
	function set_payments($payments_data)
	{
		$this->CI->session->set_userdata('payments',$payments_data);
	}
	
	function get_comment() 
	{
		return $this->CI->session->userdata('comment');
	}

	function set_comment($comment) 
	{
		$this->CI->session->set_userdata('comment', $comment);
	}

	function clear_comment() 	
	{
		$this->CI->session->unset_userdata('comment');
	}
	
	function get_email_receipt() 
	{
		return $this->CI->session->userdata('email_receipt');
	}

	function set_email_receipt($email_receipt) 
	{
		$this->CI->session->set_userdata('email_receipt', $email_receipt);
	}

	function clear_email_receipt() 	
	{
		$this->CI->session->unset_userdata('email_receipt');
	}

	function add_payment( $payment_id, $payment_amount )
	{
		$payments = $this->get_payments();
		$payment = array( $payment_id=>
		array(
			'payment_type' => $payment_id,
			'payment_amount' => $payment_amount
			)
		);

		//método de pago ya existe, añadir un meonto a pagar
		if( isset( $payments[$payment_id] ) )
		{
			$payments[$payment_id]['payment_amount'] += $payment_amount;
		}
		else
		{
			//adicionar a un array exstente
			$payments += $payment;
		}

		$this->set_payments( $payments );
		return true;

	}

	//Multiples Paogs editar
	function edit_payment($payment_id,$payment_amount)
	{
		$payments = $this->get_payments();
		if(isset($payments[$payment_id]))
		{
			$payments[$payment_id]['payment_type'] = $payment_id;
			$payments[$payment_id]['payment_amount'] = $payment_amount;
			$this->set_payments($payment_id);
		}

		return false;
	}

	//borra Multiples Paogs
	function delete_payment( $payment_id )
	{
		$payments = $this->get_payments();
		unset( $payments[urldecode( $payment_id )] );
		$this->set_payments( $payments );
	}

	//Multiples Paogs vacios
	function empty_payments()
	{
		$this->CI->session->unset_userdata('payments');
	}

	//trae Multiples Pagos
	function get_payments_total()
	{
		$subtotal = 0;
		foreach($this->get_payments() as $payments)
		{
		    $subtotal+=$payments['payment_amount'];
		}
		return to_currency_no_money($subtotal);
	}

	//Multiples Paogs monto
	function get_amount_due()
	{
		$amount_due=0;
		$payment_total = $this->get_payments_total();
		$sales_total=$this->get_total();
		$amount_due=to_currency_no_money($sales_total - $payment_total);
		return $amount_due;
	}

	function get_customer()
	{
		if(!$this->CI->session->userdata('customer'))
			$this->set_customer(-1);

		return $this->CI->session->userdata('customer');
	}

	function set_customer($customer_id)
	{
		$this->CI->session->set_userdata('customer',$customer_id);
	}

	function get_mode()
	{
		if(!$this->CI->session->userdata('sale_mode'))
			$this->set_mode('sale');

		return $this->CI->session->userdata('sale_mode');
	}

	function set_mode($mode)
	{
		$this->CI->session->set_userdata('sale_mode',$mode);
	}

	function add_item($item_id,$quantity=1,$discount=0,$price=null,$description=null)
	{
		//estar seguro existe elemento
		if(!$this->CI->Item->exists($item_id))
		{
			//tratar de conseguir un producto identificador dado el numero
			$item_id = $this->CI->Item->get_item_id($item_id);

			if(!$item_id)
				return false;
		}


		//serialización y Descripción

		//trae todos los elementos de la tabla hasta el momento ...
		$items = $this->get_cart();

        /* Tenemos que recorrer todos los elementos de la cesta.
         Si el artículo ya está ahí.
         También tenemos que obtener la siguiente tecla que vamos a utilizar en caso tenemos que añadir el producto a la lista. Puesto que los artículos se pueden eliminar, no podemos usar un recuento. utilizamos la más alta tecla + 1.*/

        $maxkey=0;                       //nota más alta hasta el momento
        $itemalreadyinsale=FALSE;        //No se encontró el producto todavía.
		$insertkey=0;                    //se usapara hacer una nueva entrada.
		$updatekey=0;                    //KSe utiliza para actualizar (cantidad)

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
			'item_number'=>$this->CI->Item->get_info($item_id)->item_number,
			'description'=>$description!=null ? $description: $this->CI->Item->get_info($item_id)->description,
			'quantity'=>$quantity,
            'discount'=>$discount,
			'price'=>$price!=null ? $price: $this->CI->Item->get_info($item_id)->unit_price
			)
		);

		//producto ya existe añadir la cantidad
		if($itemalreadyinsale && ($this->CI->Item->get_info($item_id)) )
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
	
	function out_of_stock($item_id)
	{
		//Objeto ya existe
		if(!$this->CI->Item->exists($item_id))
		{
			//tratar de conseguir un elemento identificador dado numero de producto
			$item_id = $this->CI->Item->get_item_id($item_id);

			if(!$item_id)
				return false;
		}
		
		$item = $this->CI->Item->get_info($item_id);
		$quanity_added = $this->get_quantity_already_added($item_id);
		
		if ($item->quantity - $quanity_added < 0)
		{
			return true;
		}
		
		return false;
	}
	
	function get_quantity_already_added($item_id)
	{
		$items = $this->get_cart();
		$quanity_already_added = 0;
		foreach ($items as $item)
		{
			if($item['item_id']==$item_id)
			{
				$quanity_already_added+=$item['quantity'];
			}
		}
		
		return $quanity_already_added;
	}
	
	function get_item_id($line_to_get)
	{
		$items = $this->get_cart();

		foreach ($items as $line=>$item)
		{
			if($line==$line_to_get)
			{
				return $item['item_id'];
			}
		}
		
		return -1;
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

	function is_valid_receipt($receipt_sale_id)
	{
		//FRA #
		$pieces = explode(' ',$receipt_sale_id);

		if(count($pieces)==2)
		{
			return $this->CI->Sale->exists($pieces[1]);
		}

		return false;
	}
	
	
	function return_entire_sale($receipt_sale_id)
	{
		//FRA #
		$pieces = explode(' ',$receipt_sale_id);
		$sale_id = $pieces[1];

		$this->empty_cart();
		$this->remove_customer();

		foreach($this->CI->Sale->get_sale_items($sale_id)->result() as $row)
		{
			$this->add_item($row->item_id,-$row->quantity_purchased,$row->discount_percent,$row->item_unit_price,$row->description);
		}
		$this->set_customer($this->CI->Sale->get_customer($sale_id)->person_id);
	}
	
	
	function copy_entire_sale($sale_id)
	{
		$this->empty_cart();
		$this->remove_customer();

		foreach($this->CI->Sale->get_sale_items($sale_id)->result() as $row)
		{
			$this->add_item($row->item_id,$row->quantity_purchased,$row->discount_percent,$row->item_unit_price,$row->description);
		}
		foreach($this->CI->Sale->get_sale_payments($sale_id)->result() as $row)
		{
			$this->add_payment($row->payment_type,$row->payment_amount);
		}
		$this->set_customer($this->CI->Sale->get_customer($sale_id)->person_id);

	}
	
	function delete_item($line)
	{
		$items=$this->get_cart();
		unset($items[$line]);
		$this->set_cart($items);
	}

	function empty_cart()
	{
		$this->CI->session->unset_userdata('cart');
	}

	function remove_customer()
	{
		$this->CI->session->unset_userdata('customer');
	}

	function clear_mode()
	{
		$this->CI->session->unset_userdata('sale_mode');
	}

	function clear_all()
	{
		$this->clear_mode();
		$this->empty_cart();
		$this->clear_comment();
		$this->clear_email_receipt();
		$this->empty_payments();
		$this->remove_customer();
	}

	function get_taxes()
	{
		$customer_id = $this->get_customer();
		$customer = $this->CI->Customer->get_info($customer_id);

		//No cargar IVA si tenemos un cliente que no está sujeto a impuestos
		if (!$customer->taxable and $customer_id!=-1)
		{
		   return array();
		}

		$taxes = array();
		foreach($this->get_cart() as $line=>$item)
		{
			$tax_info = $this->CI->Item_taxes->get_info($item['item_id']);

			foreach($tax_info as $tax)
			{
				$name = $tax['percent'].'% ' . $tax['name'];
				$tax_amount=($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100)*(($tax['percent'])/100);


				if (!isset($taxes[$name]))
				{
					$taxes[$name] = 0;
				}
				$taxes[$name] += $tax_amount;
			}
		}

		return $taxes;
	}

	function get_subtotal()
	{
		$subtotal = 0;
		foreach($this->get_cart() as $item)
		{
		    $subtotal+=($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100);
		}
		return to_currency_no_money($subtotal);
	}

	function get_total()
	{
		$total = 0;
		foreach($this->get_cart() as $item)
		{
            $total += ( $item['price'] * $item['quantity'] - $item['price'] * $item['quantity'] * $item['discount'] / 100);
		}

		foreach($this->get_taxes() as $tax)
		{
			$total+=$tax;
		}

		return to_currency_no_money($total);
	}
}
?>