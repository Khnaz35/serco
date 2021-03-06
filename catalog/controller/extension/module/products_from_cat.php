<?php 
class ControllerExtensionModuleProductsFromCat extends Controller {
	public function index($setting) {

		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel-2/assets/owl.carousel.min.css');
		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel-2/assets/owl.theme.default.min.css');
		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel-2/owl.carousel.min.js');
	   
        static $module_productfromcategory_number = 6000;
        
		$this->language->load('extension/module/products_from_cat');
		
		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		
		$this->load->model('extension/module/products_from_cat');

		$data['heading_title'] = $this->language->get('heading_title_personal');
		
		$limit = html_entity_decode($setting['limit']);

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');

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
             
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['heading_title'] = $setting['title'];

        
        if (!$setting['position']) {
			$setting['position'] = 0;
		}
        $data['position'] = $setting['position'];
        
		$data['products'] = array();

		$results = $this->model_extension_module_products_from_cat->getProducts($setting);

		foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
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

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}

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
             
			$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'label' => $label,
					'mopt_price'  => $current_mopt_price,
					'options'  => $product_options,
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					// 'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
		}

        $data['module_productfromcategory_number'] = $module_productfromcategory_number++;
        
		return $this->load->view('extension/module/products_from_cat', $data);

	}
}