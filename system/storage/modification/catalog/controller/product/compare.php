<?php
class ControllerProductCompare extends Controller {
	public function index() {
		$this->load->language('product/compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}

		if (isset($this->request->get['remove'])) {
			$key = array_search($this->request->get['remove'], $this->session->data['compare']);

			if ($key !== false) {
				unset($this->session->data['compare'][$key]);

				$this->session->data['success'] = $this->language->get('text_remove');
			}

			$this->response->redirect($this->url->link('product/compare'));
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/compare')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_product'] = $this->language->get('text_product');
		$data['text_name'] = $this->language->get('text_name');
		$data['text_image'] = $this->language->get('text_image');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_sku'] = $this->language->get('text_sku');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_availability'] = $this->language->get('text_availability');
		$data['text_rating'] = $this->language->get('text_rating');
		$data['text_summary'] = $this->language->get('text_summary');
		$data['text_weight'] = $this->language->get('text_weight');
		$data['text_dimension'] = $this->language->get('text_dimension');
		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_more'] = $this->language->get('text_more');
		$data['text_modal_close'] = $this->language->get('text_modal_close');
		$data['text_modal_success'] = $this->language->get('text_modal_success');
        
        $data['text_bestseller'] = $this->language->get('text_bestseller');
        $data['text_special'] = $this->language->get('text_special');
        $data['text_latest'] = $this->language->get('text_latest');
        $data['text_rozn'] = $this->language->get('text_rozn');
        $data['text_mopt'] = $this->language->get('text_mopt');
        $data['text_known_opt'] = $this->language->get('text_known_opt');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['review_status'] = $this->config->get('config_review_status');

		$data['products'] = array();

		$data['attribute_groups'] = array();

		foreach ($this->session->data['compare'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_compare_width'), $this->config->get($this->config->get('config_theme') . '_image_compare_height'));
				} else {
					$image = false;
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

				if ($product_info['quantity'] <= 0) {
					$availability = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$availability = $product_info['quantity'];
				} else {
					$availability = $this->language->get('text_instock');
				}

				$attribute_data = array();

				$attribute_groups = $this->model_catalog_product->getProductAttributes($product_id);

				foreach ($attribute_groups as $attribute_group) {
					foreach ($attribute_group['attribute'] as $attribute) {
						$attribute_data[$attribute['attribute_id']] = $attribute['text'];
					}
				}
                
                
                 $label = 'label_empty';
                 if ($product_info['jan'] == 1) {
                    $label = 'label_latest';
                 }
                 else {
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
                 
                 
				$data['products'][$product_id] = array(
					'product_id'   => $product_info['product_id'],
					'name'         => $product_info['name'],
					'thumb'        => $image,
					'price'        => $price,
					'special'      => $special,
                     'label' => $label,
                     'mopt_price'  => $current_mopt_price,
                     'options'  => $product_options,
					//'description'  => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
					'model'        => $product_info['model'],
                    'sku'          => $product_info['sku'],
					//'manufacturer' => $product_info['manufacturer'],
					'availability' => $availability,
					'minimum'      => $product_info['minimum'] > 0 ? $product_info['minimum'] : 1,
					'rating'       => (int)$product_info['rating'],
					'reviews'      => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					//'weight'       => $this->weight->format($product_info['weight'], $product_info['weight_class_id']),
					//'length'       => $this->length->format($product_info['length'], $product_info['length_class_id']),
					//'width'        => $this->length->format($product_info['width'], $product_info['length_class_id']),
					//'height'       => $this->length->format($product_info['height'], $product_info['length_class_id']),
					'attribute'    => $attribute_data,
					'href'         => $this->url->link('product/product', 'product_id=' . $product_id),
					'remove'       => $this->url->link('product/compare', 'remove=' . $product_id)
				);

				foreach ($attribute_groups as $attribute_group) {
					$data['attribute_groups'][$attribute_group['attribute_group_id']]['name'] = $attribute_group['name'];

					foreach ($attribute_group['attribute'] as $attribute) {
						$data['attribute_groups'][$attribute_group['attribute_group_id']]['attribute'][$attribute['attribute_id']]['name'] = $attribute['name'];
					}
				}
			} else {
				unset($this->session->data['compare'][$key]);
			}
		}

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('product/compare', $data));
	}

	public function add() {
		$this->load->language('product/compare');

		$json = array();

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (!in_array($this->request->post['product_id'], $this->session->data['compare'])) {
				if (count($this->session->data['compare']) >= 4) {
					array_shift($this->session->data['compare']);
				}

				$this->session->data['compare'][] = $this->request->post['product_id'];
			}
            
            $this->load->model('tool/image');
			if ($product_info['image']) {
			     $image = $this->model_tool_image->resize($product_info['image'], 180, 275);
			} else {
			     $image = $this->model_tool_image->resize('placeholder.png', 180, 275);
			}
            $json['image_compare'] = $image;
            
            $json['success_name'] = $product_info['name'];
            
			$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('product/compare'));
$json['success_name'] = sprintf($this->language->get('text_success_name'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name']);

			$json['total'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
