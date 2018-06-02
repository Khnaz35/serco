<?php
class ControllerAccountWishList extends Controller {
	public function index() {

        // start: OCdevWizard SMWWL
        $this->load->model('ocdevwizard/ocdevwizard_setting');
        $smwwl_form_data = $this->model_ocdevwizard_ocdevwizard_setting->getSettingData('smart_wishlist_without_login_form_data');  
       
        if (isset($smwwl_form_data['activate']) && $smwwl_form_data['activate']) {
          $smwwl_status = 1;
        } else {
          $smwwl_status = 0;
        }
        // end: OCdevWizard SMWWL
      
		
        // start: OCdevWizard SMWWL
        if (!$this->customer->isLogged() && $smwwl_status == 0) {
        // end: OCdevWizard SMWWL
      
			$this->session->data['redirect'] = $this->url->link('account/wishlist', '', true);

			$this->response->redirect($this->url->link('account/login', '', true));
		}

		$this->load->language('account/wishlist');

		$this->load->model('account/wishlist');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['remove'])) {
			// Remove Wishlist
			$this->model_account_wishlist->deleteWishlist($this->request->get['remove']);

			$this->session->data['success'] = $this->language->get('text_remove');

			$this->response->redirect($this->url->link('account/wishlist'));
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();
//start
		$data['text_modal_close'] = $this->language->get('text_modal_close');
		$data['text_modal_success'] = $this->language->get('text_modal_success');
		$data['text_modal_warning'] = $this->language->get('text_modal_warning');
//end
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/wishlist')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_more'] = $this->language->get('text_more');
		$data['text_modal_close'] = $this->language->get('text_modal_close');
		$data['text_modal_success'] = $this->language->get('text_modal_success');

		$data['column_image'] = $this->language->get('column_image');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_model'] = $this->language->get('column_model');
		$data['column_stock'] = $this->language->get('column_stock');
		$data['column_price'] = $this->language->get('column_price');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_cart'] = $this->language->get('button_cart');
//start
		$data['text_bestseller'] = $this->language->get('text_bestseller');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_latest'] = $this->language->get('text_latest');

		$data['text_dimentions_table'] = $this->language->get('text_dimentions_table');
		$data['text_rozn'] = $this->language->get('text_rozn');
		$data['text_mopt'] = $this->language->get('text_mopt');
		$data['text_opt'] = $this->language->get('text_opt');
		$data['text_known'] = $this->language->get('text_known');
		$data['text_known_opt'] = $this->language->get('text_known_opt');
		$data['text_more'] = $this->language->get('text_more');
// end            
		$data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['products'] = array();

		$results = $this->model_account_wishlist->getWishlist();

		foreach ($results as $result) {
			$product_info = $this->model_catalog_product->getProduct($result['product_id']);

			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_wishlist_width'), $this->config->get($this->config->get('config_theme') . '_image_wishlist_height'));
				} else {
					$image = false;
				}

				if ($product_info['quantity'] <= 0) {
					$stock = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $product_info['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

//start
			$label = 'label_empty';
			if ($product_info['jan'] == 1) {
			   $label = 'label_latest';
			} else {
				if ($product_info['jan'] == 2) {
				   $label = 'label_special';
				}
				else {
					if ($product_info['jan'] == 3) {
					   $label = 'label_bestseller';
					}
				}
			}

			$current_product_mopt_price = $this->model_catalog_product->getProductMOptPrice($product_info['product_id']);
			$current_mopt_price = false; 
			if ($current_product_mopt_price){
			   if ((float)$current_product_mopt_price) {
				   $current_mopt_price = $this->currency->format($this->tax->calculate($current_product_mopt_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			   }
			}

			if ((int)$this->config->get('config_customer_group_id') != 1) {
			   $special = false;

			   $current_product_rozn_price = $this->model_catalog_product->getProductRoznPrice($product_info['product_id']);
				if ($current_product_rozn_price){
				   if ((float)$current_product_rozn_price) {
					   $price = $this->currency->format($this->tax->calculate($current_product_rozn_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				   }
				}
			}

			$product_options = array();

			foreach ($this->model_catalog_product->getProductOptions($product_info['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
				    if ($option['type'] == 'radio') {
						$product_option_value_data[] = array(
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'quantity'                => $option_value['quantity']
						);
                    }
				}
                if ($option['option_id'] == 14) {
    				$product_options[] = array(
    					'product_option_id'    => $option['product_option_id'],
    					'product_option_value' => $product_option_value_data,
    					'option_id'            => $option['option_id'],
    					'name'                 => $option['name'],
    					'type'                 => $option['type'],
    					'value'                => $option['value'],
    					'required'             => $option['required']
    				);
                }
			}
// end            
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
//start
					'label' => $label,
					'mopt_price'  => $current_mopt_price,
					'options'  => $product_options,
//             end
					'thumb'      => $image,
					'name'       => $product_info['name'],
					'model'      => $product_info['model'],
					'stock'      => $stock,
					'price'      => $price,
					'special'    => $special,
					'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
					'remove'     => $this->url->link('account/wishlist', 'remove=' . $product_info['product_id'])
				);
			} else {
				$this->model_account_wishlist->deleteWishlist($result['product_id']);
			}
		}

		$data['continue'] = $this->url->link('account/account', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/wishlist', $data));
	}

	public function add() {

        // start: OCdevWizard SMWWL
        $this->load->model('ocdevwizard/ocdevwizard_setting');
        $smwwl_form_data = $this->model_ocdevwizard_ocdevwizard_setting->getSettingData('smart_wishlist_without_login_form_data');  
       
        if (isset($smwwl_form_data['activate']) && $smwwl_form_data['activate']) {
          $smwwl_status = 1;
        } else {
          $smwwl_status = 0;
        }
        // end: OCdevWizard SMWWL
      
		$this->load->language('account/wishlist');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
            
			
        // start: OCdevWizard SMWWL
        if ($this->customer->isLogged() || $smwwl_status == 1) {
        // end: OCdevWizard SMWWL
      
				// Edit customers cart
				$this->load->model('account/wishlist');

				$this->model_account_wishlist->addWishlist($this->request->post['product_id']);
                
                $json['success_name'] = $product_info['name'];
                
				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . (int)$this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));
$json['success_name'] = sprintf($this->language->get('text_success_name'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name']);

				$json['total'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		  
                $this->load->model('tool/image');
    			if ($product_info['image']) {
    			     $image = $this->model_tool_image->resize($product_info['image'], 180, 275);
    			} else {
    			     $image = $this->model_tool_image->resize('placeholder.png', 180, 275);
    			}
                $json['image_wishlist'] = $image;
			} else {
				if (!isset($this->session->data['wishlist'])) {
					$this->session->data['wishlist'] = array();
				}

				$this->session->data['wishlist'][] = $this->request->post['product_id'];

				$this->session->data['wishlist'] = array_unique($this->session->data['wishlist']);
            
				$json['success'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true), $this->url->link('product/product', 'product_id=' . (int)$this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));

				$json['total'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
