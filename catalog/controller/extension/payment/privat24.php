<?php
class ControllerExtensionPaymentPrivat24 extends Controller {
	private $action = "https://api.privatbank.ua/p24api/ishop";
	
	public function index() {
		$data['button_confirm'] = $this->language->get('button_confirm');
		$data['button_continue_action'] = $this->url->link('extension/payment/privat24/checkout', '', true);

		unset($this->session->data['privat24']);
		
		return $this->load->view('extension/payment/privat24', $data);
	}
	
	public function checkout() {
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$this->response->redirect($this->url->link('checkout/cart'));
		}
		
		$this->language->load('extension/payment/privat24');
		$this->load->model('checkout/order');

		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		
		$time = date("d.m.Y H:i:s");
		$timenow = time();
		
		$merchant_id = $this->config->get('privat24_merchant_id');
		$order_data = "|".$this->session->data['order_id']."|";
		$order_details = sprintf($this->language->get('text_order_details'), $this->session->data['order_id'], $time);
		$ext_details = $this->language->get('text_ext_details');
		$server_url = $this->url->link('extension/payment/privat24/callback', '', true);
		$return_url = $this->url->link('extension/payment/privat24/returnUrl', '', true);
		
		$order_total = $this->currency->convert($order_info['total'], $order_info['currency_code'], $this->config->get('privat24_currency'));
		$amt = $this->currency->format($order_total, $this->config->get('privat24_currency'), $order_info['currency_value'], FALSE);
		$ccy = $this->config->get('privat24_currency');
		
		echo '
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
		<html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>'.$this->language->get('text_title').'</title>
		</head>
		<body>
		<form id ="privat24_send" action="'.$this->action.'" accept-charset="utf-8" method="post">
			<input type="hidden" name="amt" value="'.$amt.'" />
			<input type="hidden" name="ccy" value="'.$ccy.'" />
			<input type="hidden" name="merchant" value="'.$merchant_id.'" />
			<input type="hidden" name="order" value="'.$order_data.'" />
			<input type="hidden" name="details" value="'.$order_details.'" />
			<input type="hidden" name="ext_details" value="'.$ext_details.'" />
			<input type="hidden" name="pay_way" value="privat24" />
			<input type="hidden" name="return_url" value="'.$return_url.'" />
			<input type="hidden" name="server_url" value="'.$server_url.'" />
			<input style="display:none;" type="submit" />
		</form>
		<script type="text/javascript">
			window.onload = function() {
			   document.forms["privat24_send"].submit();
			}
		</script>
		</body>
		</html>
		';
	}
	
	public function callback() {
		if (isset($this->request->post["payment"]) and isset($this->request->post["signature"])) {
			$response_payment = str_replace("&amp;", "&", $this->request->post["payment"]);
			$signature = sha1(md5($response_payment.$this->config->get('privat24_secret_key')));
			
			if ($signature == $this->request->post["signature"]) {
				parse_str($response_payment, $result);
				$order = $result["order"];
				$order_id = trim($order,"|");
				
				if (($result['state'] == 'ok') || ($result['state'] == 'test')) {
					$this->load->language('extension/payment/privat24');
					$this->load->model('checkout/order');
					$this->model_checkout_order->addOrderHistory($order_id, $this->config->get('privat24_order_status_id'), $this->language->get('text_title').' (state='.$result['state'].'); ref: '.$result['ref']);
					
					$this->success();
					die();
				} else {
					$this->error();
					die();
				}
			} else {
				$this->error();
				die();
			}
		} else {
			$this->error();
			die();
		}
	}
	
	public function returnUrl() {
		if (isset($this->request->post["payment"]) and isset($this->request->post["signature"])) {
			$response_payment = str_replace("&amp;", "&", $this->request->post["payment"]);
			$signature = sha1(md5($response_payment.$this->config->get('privat24_secret_key')));
			if ($signature == $this->request->post["signature"]) {
				parse_str($response_payment, $result);
				$order = $result["order"];
				$order_id = trim($order,"|");
				
				if (($result['state'] == 'ok') || ($result['state'] == 'test')) {
					$this->success();
				} else {
					$this->error();
				}
			} else {
				$this->error();
			}
		} else {
			$this->error();
		}
	}
	
	public function success() {
		$this->response->redirect($this->url->link('checkout/success'));
	}
	
	public function error() {
		$this->response->redirect($this->url->link('checkout/cart'));
	}
}