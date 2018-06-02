<?php
class ControllerCheckoutSuccess extends Controller {
	public function index() {
		$this->load->language('checkout/success');

		
		
		$data = array();
		if (isset($this->session->data['order_id'])) {
			$order_id = $this->session->data['order_id'];
		} elseif(isset($this->request->get['order'])){
			$order_id = $this->request->get['order'];
		}
		$order_info = array();
		if($order_id){
			
			$this->load->model('account/order');
			$order_info = $this->model_account_order->getOrder($order_id);
		}
		
		if($order_info){
			
			$data['order_id'] = $order_id;
		

			$this->load->model('catalog/product');
			$this->load->model('tool/upload');
			$this->load->model('tool/image');

			$products = $this->model_account_order->getOrderProducts($order_id);
			foreach ($products as $product) {
				$product_full = $this->model_catalog_product->getProduct($product['product_id']);
				$image = ''; 
				$sku = '';
				if($product_full ){
					if(!empty($product_full['image'])){
						$image = $this->model_tool_image->resize($product_full['image'], 85, 85);
					}
				}
				
				$data['products'][] = array(
					'name'     => $product['name'],
					'model'    => $product['model'],
					'thumb'    => $image,
					'href'     => $this->url->link('product/product', 'product_id='.$product['product_id']),
					'quantity' => $product['quantity'],
					'price'    => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
					'total'    => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']),

				);
			}
			$data['total'] = $this->currency->format($order_info['total'], $order_info['currency_code']);
			
			$data['order'] = $order_info;
		
			$this->cart->clear();//

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				if ($this->customer->isLogged()) {
					$activity_data = array(
						'customer_id' => $this->customer->getId(),
						'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
						'order_id'    => $order_id
					);

					$this->model_account_activity->addActivity('order_account', $activity_data);
				} 
			}

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['guest']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
			unset($this->session->data['totals']);
//		} standart end if

			$this->document->setTitle($this->language->get('heading_title'));

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);

	//		$data['breadcrumbs'][] = array(
	//			'text' => $this->language->get('text_basket'),
	//			'href' => $this->url->link('checkout/cart')
	//		);
	//
	//		$data['breadcrumbs'][] = array(
	//			'text' => $this->language->get('text_checkout'),
	//			'href' => $this->url->link('checkout/checkout', '', true)
	//		);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_success'),
				'href' => $this->url->link('checkout/success', 'order=' . $order_id)
			);

			$data['heading_title'] = $this->language->get('heading_title');

			if ($this->customer->isLogged()) {
				$data['text_message'] = sprintf($this->language->get('text_customer'), $this->url->link('account/account', '', true), $this->url->link('account/order', '', true), $this->url->link('account/download', '', true), $this->url->link('information/contact'));
			} else {
				$data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
			}

			$data['button_continue'] = $this->language->get('button_continue');
			$data['text_shipping_method'] = $this->language->get('text_shipping_method');

			$data['continue'] = $this->url->link('common/home');
			$data['text_details'] = sprintf($this->language->get('text_details'), $data['order_id']);
			$data['text_resp'] = sprintf($this->language->get('text_resp'), $data['order_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/success', $data));


		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);


			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('checkout/success', 'order=' . $order_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
		
		
	}
}