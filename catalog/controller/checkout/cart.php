<?php
class ControllerCheckoutCart extends Controller {
	private $address = array();
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->address['country_id'] = (($this->config->get('config_country_id'))? $this->config->get('config_country_id'): 0);
		$this->address['zone_id'] = (($this->config->get('config_zone_id'))? $this->config->get('config_zone_id'): 0);
	}
	 public function index() {
		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);
		


		$this->document->addStyle('catalog/view/javascript/slick/slick-theme.css');
		$this->document->addStyle('catalog/view/javascript/slick/slick.css');
		$this->document->addScript('catalog/view/javascript/slick/slick.min.js');
//		$this->document->addScript('catalog/view/javascript/bootstrap-select.js');
		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
//			$this->document->addScript('catalog/view/javascript/jquery/jquery.maskedinput-1.2.2.js');
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_next_choice'] = $this->language->get('text_next_choice');
			$data['text_select_shipping_method'] = $this->language->get('text_select_shipping_method');
			$data['text_shipping_methods'] = $this->language->get('text_shipping_methods');
			
			$data['text_comment'] = $this->language->get('text_comment');
			$data['text_your_order'] = $this->language->get('text_your_order');
			$data['order_description'] = $this->language->get('order_description');

			$data['column_image'] = $this->language->get('column_image');
			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$data['button_update'] = $this->language->get('button_update');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_shopping'] = $this->language->get('button_shopping');
			$data['button_checkout'] = $this->language->get('button_checkout');

			$data['np_cities'] = array();
			$data['np_departments'] = array();
			$data['checked_np_city'] = 0;
			$data['checked_np_department'] = 0;
			$data['checked_shipping_method'] = 0;
			$this->addNP($data);
			

			
			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/cart/edit', '', true);

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}
			$data['products'] = $this->getProducts(); 
		
			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}
			$data['shipping_methods'] = $this->getShippingMethods($this->address);
			
			
			$data['locations'] = array();

			$this->load->model('localisation/location');

			foreach((array)$this->config->get('config_location') as $location_id) {
				$location_info = $this->model_localisation_location->getLocation($location_id);

				if ($location_info) {
					if ($location_info['image']) {
						$image = $this->model_tool_image->resize($location_info['image'], $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
					} else {
						$image = false;
					}

					$data['locations'][] = array(
						'location_id' => $location_info['location_id'],
						'name'        => $location_info['name'],
						'address'     => nl2br($location_info['address']),
						'geocode'     => $location_info['geocode'],
						'telephone'   => $location_info['telephone'],
						'fax'         => $location_info['fax'],
						'image'       => $image,
						'open'        => nl2br($location_info['open']),
						'comment'     => $location_info['comment']
					);
				}
			}
			
			
			
			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;
			
			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);
			
			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);
						
						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}
			
			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', true);

			$this->load->model('extension/extension');

			$data['modules'] = array();
			
			$files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('extension/total/' . basename($file, '.php'));
					
					if ($result) {
						$data['modules'][] = $result;
					}
				}
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/short_cart', $data));
		} else {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');
			$data['callback'] = '';
			$data_viewed_products = array(
				'title' => 'Вы смотрели',
			);
			$data['viewed_products'] = $this->load->controller('extension/module/viewed_products', $data_viewed_products);

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	protected function getProducts()
	{
		
		$this->load->model('tool/image');
		$this->load->model('tool/upload');

		$result = array();

		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {
				$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
			}

			if ($product['image']) {
				$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
			} else {
				$image = '';
			}

			$option_data = array();

			foreach ($product['option'] as $option) {
				if ($option['type'] != 'file') {
					$value = $option['value'];
				} else {
					$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

					if ($upload_info) {
						$value = $upload_info['name'];
					} else {
						$value = '';
					}
				}

				$option_data[] = array(
					'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
				);
			}

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));

				$price = $this->currency->format($unit_price, $this->session->data['currency']);
				$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
			} else {
				$price = false;
				$total = false;
			}

			$recurring = '';
			if ($product['recurring']) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($product['recurring']['trial']) {
					$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
				}

				if ($product['recurring']['duration']) {
					$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
				} else {
					$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
				}
			}

			$result[] = array(
				'cart_id'   => $product['cart_id'],
				'thumb'     => $image,
				'name'      => $product['name'],
				'model'     => $product['model'],
				'option'    => $option_data,
				'recurring' => $recurring,
				'quantity'  => $product['quantity'],
				'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
				'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
				'price'     => $price,
				'total'     => $total,
				'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
			);
		}
		return $result;
	}
	protected function getShippingMethodName($address, $code)
	{
		
		$result = '';
		$code_parts = explode('.', $code);
		$this->load->model('extension/shipping/' . $code_parts[0]);
		$quote = $this->{'model_extension_shipping_' . $code_parts[0]}->getQuote($address);
		if ($quote) {
			$result .= $quote['title'];
//			$method_data = array(
//				'title'      => $quote['title'],
//				'quote'      => $quote['quote'],
//				'sort_order' => $quote['sort_order'],
//				'error'      => $quote['error']
//			);
		}
		return $result;
	}
	protected function getShippingMethods($address)
	{
		// Shipping Methods
		$method_data = array();

		$this->load->model('extension/extension');

		$results = $this->model_extension_extension->getExtensions('shipping');

		
		
		foreach ($results as $result) {
			if ($result['code'] && $this->config->get($result['code'] . '_status')) {
				$this->load->model('extension/shipping/' . $result['code']);

				$quote = $this->{'model_extension_shipping_' . $result['code']}->getQuote($address);

				if ($quote) {
					$method_data[$result['code']] = array(
						'title'      => $quote['title'],
						'quote'      => $quote['quote'],
						'sort_order' => $quote['sort_order'],
						'error'      => $quote['error']
					);
				}
			}
		}

		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);

		return $method_data;
	}
	public function add() {
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) {
				$this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				// Totals
				$this->load->model('extension/extension');

				$totals = array();
				$taxes = $this->cart->getTaxes();
				$total = 0;
		
				// Because __call can not keep var references so we put them into an array. 			
				$total_data = array(
					'totals' => &$totals,
					'taxes'  => &$taxes,
					'total'  => &$total
				);

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$sort_order = array();

					$results = $this->model_extension_extension->getExtensions('total');

					foreach ($results as $key => $value) {
						$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
					}

					array_multisort($sort_order, SORT_ASC, $results);

					foreach ($results as $result) {
						if ($this->config->get($result['code'] . '_status')) {
							$this->load->model('extension/total/' . $result['code']);

							// We have to put the totals in an array so that they pass by reference.
							$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
						}
					}

					$sort_order = array();

					foreach ($totals as $key => $value) {
						$sort_order[$key] = $value['sort_order'];
					}

					array_multisort($sort_order, SORT_ASC, $totals);
				}

				$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function edit() {
		$this->load->language('checkout/cart');

		$json = array();

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
				$this->cart->update($key, $value);
			}

			$this->session->data['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			$this->response->redirect($this->url->link('checkout/cart'));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);

						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	public function short() {
        $this->document->addStyle('catalog/view/javascript/slick/slick-theme.css');
		$this->document->addStyle('catalog/view/javascript/slick/slick.css');
		$this->document->addScript('catalog/view/javascript/slick/slick.min.js');
        $oid = 0;
        
        $user_id = 0;
        
        $this->load->model('checkout/order');
        
        $cid = $user_id;
        $data = array();

        $json = array('success' => true);
        			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;
			
			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);
						
						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$data['totals'] = $total_data['totals'];
			$data['total'] = $total_data['total'];
			$data['taxes'] = $total_data['taxes'];


    
        $this->language->load('checkout/checkout');
        
        
        $data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
        $data['store_id'] = $this->config->get('config_store_id');
        $data['store_name'] = $this->config->get('config_name');
        
        if ($data['store_id']) {
            $data['store_url'] = $this->config->get('config_url');        
        } else {
            $data['store_url'] = HTTP_SERVER;    
        }
		
        $city = ((!empty($this->request->post['city_name']))? $this->request->post['city_name']: '---');
		
        $data['customer_id'] = (($this->customer->isLogged())? $this->customer->getId(): 0);
        $data['customer_group_id'] = (($this->customer->isLogged())? $this->customer->getGroupId(): $this->config->get('config_customer_group_id'));
        $data['firstname'] = $_POST['name'];
        $data['lastname'] = '---';
        $data['email'] = isset($this->request->post['email'])? $this->request->post['email'] :'---';
        $data['telephone'] = $_POST['phone'];
        $data['fax'] = '';
        $data['custom_field'] = '';
        
        $data['payment_firstname'] = $this->request->post['name'];
        $data['payment_lastname'] = '---';
        $data['payment_company'] = '';    
        $data['payment_company_id'] = '';    
        $data['payment_tax_id'] = '';    
        $data['payment_address_1'] = '---'; 
        $data['payment_address_2'] = '';
        $data['payment_city'] = $city; 
        $data['payment_postcode'] =  '';
        $data['payment_zone'] = ''; 
        $data['payment_zone_id'] = $this->config->get('config_zone_id');
        $data['payment_country'] = '';
        $data['payment_country_id'] = $this->config->get('config_country_id');
        $data['payment_address_format'] = '';
        
        
        $data['payment_method'] = '';
        $data['payment_code'] = 'cod';
        $data['shipping_firstname'] = $this->request->post['name'];
        $data['shipping_lastname'] = '---';    
        $data['shipping_company'] = '';    
        $data['shipping_address_1'] = '---';
        $data['shipping_address_2'] = '';
        $data['shipping_city'] = $city;
        $data['shipping_postcode'] = '';
        $data['shipping_zone'] = '';
        $data['shipping_zone_id'] = $this->config->get('config_zone_id');
        $data['shipping_country'] = '';
        $data['shipping_country_id'] = $this->config->get('config_country_id');
        $data['shipping_address_format'] = '';
        $data['shipping_code'] = ((!empty($this->request->post['shipping_code']))? $this->request->post['shipping_code']: '');
		
		if($data['shipping_code']){
			$data['shipping_method'] = $this->getShippingMethodName($this->address, $data['shipping_code']);
			switch ($data['shipping_code']){
				case 'np.np':
					if(!empty($this->request->post['department'])){
						$this->addDataToNP($data, $this->request->post['department']);
					}

					if(!empty($this->request->post['city'])){
						$this->addCityToNP($data, $this->request->post['city'], $city);
					}
					break;
				case 'pickup.pickup':
					if($this->request->post['location']){
						$this->addPickupLocation($data, $this->request->post['location']);
					}

					if($this->request->post['city']){
						$this->addCityToNP($data, $this->request->post['city'], $city);
					}
					break;
			}
			
		} else {
			$data['shipping_method'] = '';
		}

		
		
		
        $data['products'] = array();
        foreach ($this->cart->getProducts() as $product) {
            $option_data = array();

            foreach ($product['option'] as $option) {
                $option_data[] = array(
                    'product_option_id'       => $option['product_option_id'],
                    'product_option_value_id' => $option['product_option_value_id'],
                    'option_id'               => $option['option_id'],
                    'option_value_id'         => $option['option_value_id'],
                    'name'                    => $option['name'],
                    'value'                   => $option['value'],
                    'type'                    => $option['type']
                );
            }

            $data['products'][] = array(
                'product_id' => $product['product_id'],
                'name'       => $product['name'],
                'model'      => $product['model'],
                'option'     => $option_data,
                'download'   => $product['download'],
                'quantity'   => $product['quantity'],
                'subtract'   => $product['subtract'],
                'price'      => $product['price'],
                'total'      => $product['total'],
                'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
                'reward'     => $product['reward']
            );
        }

        $data['vouchers'] = array();

        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher) {
                $data['vouchers'][] = array(
                    'description'      => $voucher['description'],
                    'code'             => token(10),
                    'to_name'          => $voucher['to_name'],
                    'to_email'         => $voucher['to_email'],
                    'from_name'        => $voucher['from_name'],
                    'from_email'       => $voucher['from_email'],
                    'voucher_theme_id' => $voucher['voucher_theme_id'],
                    'message'          => $voucher['message'],
                    'amount'           => $voucher['amount']
                );
            }
        }

        $data['comment'] = $_POST['comment'];

       
        $data['affiliate_id'] = 0;
        $data['commission'] = 0;
        $data['marketing_id'] = 0;
        $data['tracking'] = '';
       
        $data['language_id'] = $this->config->get('config_language_id');
		$data['language_id'] = $this->config->get('config_language_id');
		$data['currency_id'] = $this->currency->getId($this->session->data['currency']);
		$data['currency_code'] = $this->session->data['currency'];
		$data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
		$data['ip'] = $this->request->server['REMOTE_ADDR'];

        if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
        } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
            $data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
        } else {
            $data['forwarded_ip'] = '';
        }

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
        } else {
            $data['user_agent'] = '';
        }

        if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
            $data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $data['accept_language'] = '';
        }
        
        $oid = $this->model_checkout_order->addOrder($data);
        $this->session->data['order_id'] = $oid;
        $this->model_checkout_order->addOrderHistory($oid, 1,'');
		unset($this->session->data['np']);
//        print_r($data);die;
        $this->response->setOutput('{"OrderId":'.$oid.',"success":"' . $this->url->link('checkout/success', 'order=' . $oid) . '"}');
        
    }
	
	private function addPickupLocation(&$data, $location_id)
	{
		$this->load->model('localisation/location');

		$location_info = $this->model_localisation_location->getLocation($location_id);

		$data['payment_address_1'] = $data['shipping_address_1'] = $location_info['address'];
        $data['payment_city'] = $data['shipping_city'] = $location_info['name'] . ' - ' . $location_info['comment'];

	}
	private function addCityToNP(&$data, $Ref, $default)
	{
		$this->load->model('tool/np');
		$np_cities = $this->model_tool_np->getCities(array(
								'Ref' => $Ref,
								));
		
        $data['payment_city'] = 
        $data['shipping_city'] = 
			((!empty($np_cities[0]['DescriptionRu']))? $np_cities[0]['DescriptionRu']: $default);

	}
	private function addDataToNP(&$data, $Ref)
	{
		$this->load->model('tool/np');
		$np_department = $this->model_tool_np->getDepartments(array(
								'Ref' => $Ref,
								));
		
		$data['payment_address_1'] = 
		$data['shipping_address_1'] = 
			((!empty($np_department[0]['DescriptionRu']))? $np_department[0]['DescriptionRu']: '');
        $data['payment_city'] = 
        $data['shipping_city'] = 
			((!empty($np_department[0]['CityDescriptionRu']))? $np_department[0]['CityDescriptionRu']: '');
		
		

	}
	private function addNP(&$data)
	{
		$this->load->model('tool/np');
		$np_cities = $this->model_tool_np->getCities();
		if($np_cities){
			$data['np_cities'] = $np_cities;
		} 
		if(!empty($this->session->data['np'])){
			if(!empty($this->session->data['np']['city'])){
				$data['checked_np_city'] = $this->session->data['np']['city'];
				$data['np_departments'] = $this->model_tool_np->getDepartments(array('CityRef' => $data['checked_np_city']));
			} 
			if(!empty($this->session->data['np']['department'])){
				$data['checked_np_department'] = $this->session->data['np']['department'];
			}
		}

	}
	public function department()
	{
		if(empty($this->session->data['np'])){
			$this->session->data['np'] = array();
		}
		$json = array();
		$json['departments'] = array();
		if(!empty($this->request->post['city']['ref'])){
			$this->session->data['np']['city'] = $this->request->post['city']['ref'];
			$this->load->model('tool/np');
			$json['departments'] = $this->model_tool_np->getDepartments(array('CityRef' => $this->request->post['city']['ref']));	
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	public function autocomplete()
	{
//		if(empty($this->session->data['np'])){
//			$this->session->data['np'] = array();
//		}
		$json = array();
//		if(!empty($this->request->post['city']['ref'])){
//			$this->session->data['np']['city'] = $this->request->post['city']['ref'];
//			$this->load->model('tool/np');
//			$json['departments'] = $this->model_tool_np->getDepartments(array('CityRef' => $this->request->post['city']['ref']));	
//		}
		$this->load->model('tool/np');
		$np_cities = $this->model_tool_np->getCities(array('name' => $this->request->get['name']));
		if($np_cities){
			$json = $np_cities;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	
	public function hhh()
	{
		$this->load->model('tool/np');
		$this->model_tool_np->addCities();
		$this->model_tool_np->addDepartments();
	}
	
}
