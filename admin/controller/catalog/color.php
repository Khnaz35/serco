<?php
class ControllerCatalogColor extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/color');

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/color');
        
        $this->document->addScript('view/javascript/jscolor-2.0.4/jscolor.js');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/color');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_color->addColor($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

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

			$this->response->redirect($this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/color');
        
        $this->document->addScript('view/javascript/jscolor-2.0.4/jscolor.js');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/color');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_color->editColor($this->request->get['color_set_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

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

			$this->response->redirect($this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/color');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $color_id) {
				$this->model_catalog_color->deleteColor($color_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

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

			$this->response->redirect($this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('catalog/color/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('catalog/color/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['colors'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$color_total = $this->model_catalog_color->getTotalColors();

		$results = $this->model_catalog_color->getColors($filter_data);

		foreach ($results as $result) {
			$data['colors'][] = array(
				'color_set_id' => $result['color_set_id'],
				'name'      => $result['name'],
				'status'    => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'edit'      => $this->url->link('catalog/color/edit', 'token=' . $this->session->data['token'] . '&color_set_id=' . $result['color_set_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_status'] = $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $color_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($color_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($color_total - $this->config->get('config_limit_admin'))) ? $color_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $color_total, ceil($color_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['color_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_default'] = $this->language->get('text_default');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_product_name'] = $this->language->get('entry_product_name');
		$data['entry_color_name'] = $this->language->get('entry_color_name');
		$data['entry_color_code'] = $this->language->get('entry_color_code');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['product_name'])) {
			$data['error_product_name'] = $this->error['product_name'];
		} else {
			$data['error_product_name'] = '';
		}

		if (isset($this->error['color_name'])) {
			$data['error_color_name'] = $this->error['color_name'];
		} else {
			$data['error_color_name'] = '';
		}

		if (isset($this->error['color_code'])) {
			$data['error_color_code'] = $this->error['color_code'];
		} else {
			$data['error_color_code'] = '';
		}

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['color_set_id'])) {
			$data['action'] = $this->url->link('catalog/color/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('catalog/color/edit', 'token=' . $this->session->data['token'] . '&color_set_id=' . $this->request->get['color_set_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('catalog/color', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['color_set_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$color_info = $this->model_catalog_color->getColor($this->request->get['color_set_id']);
		}

		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($color_info)) {
			$data['name'] = $color_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($color_info)) {
			$data['status'] = $color_info['status'];
		} else {
			$data['status'] = true;
		}

		$this->load->model('catalog/product');
        
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
        
        /*
		$this->load->model('tool/image');
        */
        

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
                
		if (isset($this->request->post['set_colors'])) {
			$set_colors = $this->request->post['set_colors'];
		} elseif (isset($this->request->get['color_set_id'])) {
			$set_colors = $this->model_catalog_color->getColorSetColors($this->request->get['color_set_id']);
		} else {
			$set_colors = array();
		}




		$this->load->model('tool/image');
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$data['set_colors'] = array();

        $product_info = array();
        
		foreach ($set_colors as $set_color) {
		  
    		if (!empty($set_color)) {
    			$color_image = $set_color['color_image'];
    		} else {
    			$color_image = $data['placeholder'];
    		}
    
    		if (!empty($set_color) && is_file(DIR_IMAGE . $set_color['color_image'])) {
    			$color_thumb = $this->model_tool_image->resize($set_color['color_image'], 100, 100);
    		} else {
    			$color_thumb = $data['placeholder'];
    		}

        
			$product_info = $this->model_catalog_product->getProductDescriptions($set_color['product_id']);
            
			$data['set_colors'][] = array(
				'product_id'    => $set_color['product_id'],
				'product_info'  => $product_info,
				'color_name'    => $set_color['color_name'],
				'image'         => $color_image,
				'thumb'         => $color_thumb,
				'sort_order'    => $set_color['sort_order']
			);
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_form.tpl', $data));
	}


	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/color')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        
		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 255)) {
			$this->error['name'] = $this->language->get('error_name');
		}
        
		if (isset($this->request->post['color'])) {
			foreach ($this->request->post['color'] as $color => $color_row) {

        		/*if ((!isset($color_row['product_id'])) || (utf8_strlen($color_row['product_id']) < 1)) {
        			$this->error['color_product_id'][$color] = $this->language->get('error_product_id');
        		}*/
                
                /*foreach ($color_row['color_name'] as $language_id => $value) {
            		if ((utf8_strlen($value) < 1) || (utf8_strlen($value) > 255)) {
            			$this->error['color_name'][$color][$language_id] = $this->language->get('error_color_name');
            		}
                }*/
                
        		/*if (utf8_strlen($color_row['color_code']) != 6) {
        			$this->error['color_code'][$color] = $this->language->get('error_color_code');
        		}*/
                
			}
            
            
		}
        
		return !$this->error;
	}


	/*
    protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/color')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        
		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 255)) {
			$this->error['name'] = $this->language->get('error_name');
		}
        
		if (isset($this->request->post['color'])) {
			foreach ($this->request->post['color'] as $color => $color_row) {

        		if ((!isset($color_row['product_id'])) || (utf8_strlen($color_row['product_id']) < 1)) {
        			$this->error['color_product_id'][$color] = $this->language->get('error_product_id');
        		}
        
        		if ((utf8_strlen($color_row['color_name']) < 1) || (utf8_strlen($color_row['color_name']) > 255)) {
        			$this->error['color_name'][$color] = $this->language->get('error_color_name');
        		}
        
        		if (utf8_strlen($color_row['color_code']) != 6) {
        			$this->error['color_code'][$color] = $this->language->get('error_color_code');
        		}
                
			}
		}
        
		return !$this->error;
	}
    */

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/color')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/product');
			$this->load->model('catalog/option');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				$option_data = array();

				$product_options = $this->model_catalog_product->getProductOptions($result['product_id']);

				foreach ($product_options as $product_option) {
					$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

					if ($option_info) {
						$product_option_value_data = array();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

							if ($option_value_info) {
								$product_option_value_data[] = array(
									'product_option_value_id' => $product_option_value['product_option_value_id'],
									'option_value_id'         => $product_option_value['option_value_id'],
									'name'                    => $option_value_info['name'],
									'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
									'price_prefix'            => $product_option_value['price_prefix']
								);
							}
						}

						$option_data[] = array(
							'product_option_id'    => $product_option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $product_option['option_id'],
							'name'                 => $option_info['name'],
							'type'                 => $option_info['type'],
							'value'                => $product_option['value'],
							'required'             => $product_option['required']
						);
					}
				}

				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'model'      => $result['model'],
					'option'     => $option_data,
					'price'      => $result['price']
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}