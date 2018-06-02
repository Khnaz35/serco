<?php
class ControllerProductProduct extends Controller {
	private $error = array();

	public function index() {
//start
	$this->document->addStyle('catalog/view/theme/cybershark/stylesheet/review_stars.css');
	$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel-2/assets/owl.carousel.min.css');
	$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel-2/assets/owl.theme.default.min.css');
	$this->document->addScript('catalog/view/javascript/jquery/owl-carousel-2/owl.carousel.min.js');
//  end           
	$data['galery_diplom'] = $this->load->controller('information/galery_diplom');	      
	$this->document->addStyle('catalog/view/javascript/jquery/xzoom/xzoom.css');
        $this->document->addScript('catalog/view/javascript/jquery/xzoom/xzoom.js');
        $this->document->addScript('catalog/view/javascript/share42/share42.js');
              
		$this->load->language('product/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}


        /*$this->load->model('catalog/information');
        
		$informations = $this->model_catalog_information->getInformations();

		foreach ($informations as $result) {
			if ($result['top']) {
                if ($result['catalogue'] == 1) {
    				$catalog_arr1 = array(
    					'text' => $result['title'],
    					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id']) .'/'
    				);
                    $catalog_arr[0] = $catalog_arr1;
                }
			}
		}*/

        //if ($catalog_arr) {
            $index = 1;
            
            $output_begin = array_slice($data['breadcrumbs'], 0, $index);
            $output_end = array_slice($data['breadcrumbs'], $index);
            
            $data['breadcrumbs'] = array_merge(
                $output_begin,
                //$catalog_arr,
                $output_end
            );   
        //}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
//start
			$data['label'] = 'label_empty';
			if ($product_info['jan'] == 1) {
			   $data['label'] = 'label_latest';
			} else {
				if ($product_info['jan'] == 2) {
				   $data['label'] = 'label_special';
				}
				else {
					if ($product_info['jan'] == 3) {
					   $data['label'] = 'label_bestseller';
					}
				}
			}
             
             $product_mopt_price = $this->model_catalog_product->getProductMOptPrice($product_id);
             $data['mopt_price'] = false; 
             if ($product_mopt_price){
                if ((float)$product_mopt_price) {
    				$data['mopt_price'] = $this->currency->format($this->tax->calculate($product_mopt_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
    			}
             }
//end             
		  
          
            /* *** MICRODATA *** */
				$data['currency_microdata']	    = $this->session->data['currency'];
				$data['availability'] 			= $product_info['quantity'] ? true : false;
				$data['reviewCount']  			= (int) $product_info['reviews'];
				$data['ratingValue']  			= $product_info['rating'];
                if ($product_info['quantity'] > 0) {
                    $data['meta_stock']  			= 'InStock';
                }
                else {
                    $data['meta_stock']  			= 'OutOfStock';
                }
			/* *** MICRODATA *** */
          
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $product_info['name'],
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$this->document->setTitle($product_info['meta_title']);
			} else {
				$this->document->setTitle($product_info['name']);
			}

			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if ($product_info['meta_h1']) {
				$data['heading_title'] = $product_info['meta_h1'];
			} else {
				$data['heading_title'] = $product_info['name'];
			}


			$data['lang_id'] = $this->config->get('config_language_id');
			$data['config_text_open_form_send_order'] = $this->config->get('config_text_open_form_send_order');	
			$data['color_button_open_form_send_order'] = $this->config->get('config_color_button_open_form_send_order');			
			$data['icon_open_form_send_order'] = $this->config->get('config_icon_open_form_send_order');										
			$data['config_on_off_qo_product_page'] = $this->config->get('config_on_off_qo_product_page');					
		
			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_sku'] = $this->language->get('text_sku');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
//start
			$data['text_bestseller'] = $this->language->get('text_bestseller');
			$data['text_special'] = $this->language->get('text_special');
			$data['text_latest'] = $this->language->get('text_latest');

			$this->load->model('catalog/information');
			$data['dimentions_table'] = $this->url->link('information/information/agree', 'information_id=16', true);
			$data['text_dimentions_table'] = $this->language->get('text_dimentions_table');

			$data['text_rozn'] = $this->language->get('text_rozn');
			$data['text_mopt'] = $this->language->get('text_mopt');
			$data['text_opt'] = $this->language->get('text_opt');
			$data['text_known'] = $this->language->get('text_known');
			$data['text_known_opt'] = $this->language->get('text_known_opt');
			$data['text_more'] = $this->language->get('text_more');
// end            
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);
			$data['tab_return'] = $this->language->get('tab_return');

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
            $data['sku'] = $product_info['sku'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            
			$data['text_share'] = $this->language->get('text_share');
			$data['button_preorder'] = $this->language->get('button_preorder');

			if ($product_info['quantity'] <= 0) {
				$data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$data['stock'] = $product_info['quantity'];
			} else {
				$data['stock'] = $this->language->get('text_instock');
			}
            $data['quantity'] = $product_info['quantity'];
            
			$this->load->model('tool/image');

			$data['images'] = array();
            
			/*if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			
                $data['images'][] = array(
   					'popup' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
   					'thumb' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
				);
            } else {
				$data['popup'] = $this->model_tool_image->resize('no_image.png', $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
    				
            }

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = $this->model_tool_image->resize('no_image.png', $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
			}*/
            
            
            
            if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			
                $data['images'][] = array(
   					'popup' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
   					'thumb' => $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
				);
            }
            else {
				$data['thumb'] = $this->model_tool_image->resize('no_image.png', $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')); 
				$data['popup'] = $this->model_tool_image->resize('no_image.png', $this->config->get($this->config->get('config_theme') .'_image_popup_width'), $this->config->get($this->config->get('config_theme') .'_image_popup_height'));
            }
            
            
            
            

			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
            $add_img_limit = 3;
            $add_img_count = 0;
			foreach ($results as $result) {
    			 if ($add_img_count < $add_img_limit) {
    				$data['images'][] = array(
    					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
    					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
    				);
    			 }
                $add_img_count++;
			}

			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['price'] = false;
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			} else {
				$data['special'] = false;
			}

//start
			if ((int)$this->config->get('config_customer_group_id') != 1) {
			   $data['special'] = false;

			   $product_rozn_price = $this->model_catalog_product->getProductRoznPrice($product_id);
				if ($product_rozn_price){
				   if ((float)$product_rozn_price) {
					   $data['price'] = $this->currency->format($this->tax->calculate($product_rozn_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				   }
				}
			}
// end            
			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
				);
			}

//start	
			$data['text_color_stock_status'] = $this->language->get('text_color_stock_status');
            $data['text_colors'] = $this->language->get('text_colors');
            
            $this->document->addStyle('catalog/view/theme/cybershark/stylesheet/colors.css');
            
            $data['colors'] = array();
            
            foreach ($this->model_catalog_product->getProductColors($product_info['product_id']) as $color) {
            
                $color_selected = false;
                        
                if ($color['color_image']) {
                    $color_image = $this->model_tool_image->resize($color['color_image'], 36, 36);
                }
                else {
                    $color_image = $this->model_tool_image->resize('placeholder.png', 36, 36);
                }
                        
                if ($product_info['product_id'] == $color['product_id']) {
                    $color_selected = true;
                }
                
                $color_product_name = false;
                $color_product_image = false;
                $color_quantity = 0;
                
                $temp_color_product_data = array();
                
                $temp_color_product_data = $this->model_catalog_product->getProduct($color['product_id']);
                
                if ($temp_color_product_data) {
                    if ($temp_color_product_data['image']) {
						$color_product_image = $this->model_tool_image->resize($temp_color_product_data['image'], 80, 80);
					} else {
						$color_product_image = $this->model_tool_image->resize('placeholder.png', 80, 80);
					}
                    $color_product_name = $temp_color_product_data['name'];
                    $color_quantity = $temp_color_product_data['quantity'];
                }
                
                $data['colors'][] = array(
                        'product_id'        => $color['product_id'],
                        'product_name'      => $color_product_name,
                        'product_image'     => $color_product_image,
                        'link'              => $this->url->link('product/product', '&product_id=' . $color['product_id']),
                        'color_name'        => $color['color_name'],
                        'color_image'       => $color_image,
                        'quantity'          => $color_quantity,
                        'selected'          => $color_selected
                );
                        
            }
//end			

        $data['price_value'] = $product_info['price'];
        $data['special_value'] = $product_info['special'];
        $data['tax_value'] = (float)$product_info['special'] ? $product_info['special'] : $product_info['price'];
          
		$var_currency = array();
		$var_currency['value'] = $this->currency->getValue($this->session->data['currency']);
		$var_currency['symbol_left'] = $this->currency->getSymbolLeft($this->session->data['currency']);
		$var_currency['symbol_right'] = $this->currency->getSymbolRight($this->session->data['currency']);
		$var_currency['currency_code'] = $this->session->data['currency'];
		$var_currency['decimals'] = $this->currency->getDecimalPlace($this->session->data['currency']);
		$var_currency['decimal_point'] = $this->language->get('decimal_point');
		$var_currency['thousand_point'] = $this->language->get('thousand_point');
		$data['currency'] = $var_currency;
          
        $data['dicounts_unf'] = $discounts;

        $data['tax_class_id'] = $product_info['tax_class_id'];
        $data['tax_rates'] = $this->tax->getRates(0, $product_info['tax_class_id']);
        
			$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
				    if ($option['type'] == 'radio') {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(

          'price_value'                   => $option_value['price'],
          'points_value'                  => intval($option_value['points_prefix'].$option_value['points']),
        
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix'],
							'quantity'                => $option_value['quantity']
						);
                    }
                    else {
    					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
    						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
    							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
    						} else {
    							$price = false;
    						}
    
    						$product_option_value_data[] = array(

          'price_value'                   => $option_value['price'],
          'points_value'                  => intval($option_value['points_prefix'].$option_value['points']),
        
    							'product_option_value_id' => $option_value['product_option_value_id'],
    							'option_value_id'         => $option_value['option_value_id'],
    							'name'                    => $option_value['name'],
    							'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
    							'price'                   => $price,
    							'price_prefix'            => $option_value['price_prefix'],
    							'quantity'                => $option_value['quantity']
    						);
    					}
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = (int)$product_info['rating'];

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

			$data['products'] = array();

			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

//start
             if ((int)$this->config->get('config_customer_group_id') != 1) {
                $data['special'] = false;
                
                $product_rozn_price = $this->model_catalog_product->getProductRoznPrice($product_id);
                 if ($product_rozn_price){
                    if ((float)$product_rozn_price) {
        				$data['price'] = $this->currency->format($this->tax->calculate($product_rozn_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
        			}
                 }
             }
// end            
				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

//start
			$label = 'label_empty';
			if ($result['jan'] == 1) {
			   $label = 'label_latest';
			}
			else {
				if ($result['jan'] == 2) {
				   $label = 'label_special';
				}
				else {
					if ($result['jan'] == 3) {
					   $label = 'label_bestseller';
					}
				}
			}

			$current_product_mopt_price = $this->model_catalog_product->getProductMOptPrice($result['product_id']);
			$current_mopt_price = false; 
			if ($current_product_mopt_price){
			   if ((float)$current_product_mopt_price) {
				   $current_mopt_price = $this->currency->format($this->tax->calculate($current_product_mopt_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
			   }
			}

			if ((int)$this->config->get('config_customer_group_id') != 1) {
			   $special = false;

			   $current_product_rozn_price = $this->model_catalog_product->getProductRoznPrice($result['product_id']);
				if ($current_product_rozn_price){
				   if ((float)$current_product_rozn_price) {
					   $price = $this->currency->format($this->tax->calculate($current_product_rozn_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				   }
				}
			}


			$product_options = array();

			foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
				    if ($option['type'] == 'radio') {
						$product_option_value_data[] = array(

          'price_value'                   => $option_value['price'],
          'points_value'                  => intval($option_value['points_prefix'].$option_value['points']),
        
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
//end             
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
//start
             'label' => $label,
             'mopt_price'  => $current_mopt_price,
             'options'  => $product_options,
//end             
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}

                        
                      $data['product_color']=$this->model_catalog_product->getProductColor($product_id);
                        
                      $relative_colors=$this->model_catalog_product->getRelativeProductsColor($product_id);
                        
                      foreach ($relative_colors as $product_color) 
                      {
                          $data['relative_products_color'][] = array(
                              'name'  => $product_color['name'],
                              'color_image'  => "image/".$product_color['color_image'],
                              'link' => $this->url->link('product/product', 'product_id=' . $product_color['product_id']) 
                          );  
                      };
                      
                       
                        
                        $data['product_link']= $this->url->link('product/product', 'product_id=' . $product_id);        
                       
                        
			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

                        
                        
                        
                        
			$this->response->setOutput($this->load->view('product/product', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
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

	public function review() {
        $limit = 8;
        
		$this->load->language('product/product');

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * $limit, $limit);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($review_total - $limit)) ? $review_total : ((($page - 1) * $limit) + $limit), $review_total, ceil($review_total / $limit));

		$this->response->setOutput($this->load->view('product/review', $data));
	}

	public function write() {
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 1) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {
		$this->load->language('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
