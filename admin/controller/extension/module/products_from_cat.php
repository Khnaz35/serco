<?php
class ControllerExtensionModuleProductsFromCat extends Controller {
	private $error = array();
	
	public function index() {
		$this->load->language('extension/module/products_from_cat');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/module');
		$this->load->model('catalog/category');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('products_from_cat', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['link_enabled'] = $this->language->get('link_enabled');
		$data['link_disabled'] = $this->language->get('link_disabled');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['text_not_has_children'] = $this->language->get('text_not_has_children');
		$data['text_has_children'] = $this->language->get('text_has_children');
		$data['entry_children'] = $this->language->get('entry_children');
		

		$data['entry_status'] = $this->language->get('entry_status');

		$data['entry_personal_limit'] = $this->language->get('entry_personal_limit');
		$data['entry_overall_status'] = $this->language->get('entry_overall_status');
		$data['entry_overall_limit'] = $this->language->get('entry_overall_limit');


		$data['entry_position'] = $this->language->get('entry_position');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');

		$data['show_link'] = $this->language->get('show_link');

		$data['token'] = $this->session->data['token'];

				
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

		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = '';
		}

		if (isset($this->error['width'])) {
			$data['error_width'] = $this->error['width'];
		} else {
			$data['error_width'] = '';
		}

		if (isset($this->error['height'])) {
			$data['error_height'] = $this->error['height'];
		} else {
			$data['error_height'] = '';
		}

		if (isset($this->error['limit'])) {
			$data['error_limit'] = $this->error['limit'];
		} else {
			$data['error_limit'] = '';
		}
						
  		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token']."&type=module", 'SSL'),
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/products_from_cat', 'token=' . $this->session->data['token'], 'SSL'),
   		);
		
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/products_from_cat', 'token=' . $this->session->data['token'], true);
		} else {
			$data['action'] = $this->url->link('extension/module/products_from_cat', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
		}

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token']."&type=module", true);

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['title'])) {
			$data['title'] = $this->request->post['title'];
		} elseif (!empty($module_info)) {
			$data['title'] = $module_info['title'];
		} else {
			$data['title'] = '';
		}

		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info)) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = 130;
		}

		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info)) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = 100;
		}

		if (isset($this->request->post['limit'])) {
			$data['limit'] = $this->request->post['limit'];
		} elseif (!empty($module_info)) {
			$data['limit'] = $module_info['limit'];
		} else {
			$data['limit'] = 5;
		}

		if (isset($this->request->post['position'])) {
			$data['position'] = $this->request->post['position'];
		} elseif (!empty($module_info)) {
			$data['position'] = $module_info['position'];
		} else {
			$data['position'] = 0;
		}

		// if (isset($this->request->post['link'])) {
		// 	$data['link'] = $this->request->post['link'];
		// } elseif (!empty($module_info)) {
		// 	$data['link'] = $module_info['link'];
		// } else {
		// 	$data['link'] = '';
		// }

		if (isset($this->request->post['children'])) {
			$data['children'] = $this->request->post['children'];
		} elseif (!empty($module_info)) {
			$data['children'] = $module_info['children'];
		} else {
			$data['children'] = '';
		}

		if (isset($this->request->post['categories'])) {
			$data['products'] = $this->request->post['categories'];
		} elseif (!empty($module_info)) {
			$data['categories'] = array();
			foreach ( $module_info['categories'] as $cat ){
				$data['categories'][] = $this->model_catalog_category->getCategory($cat);
			}
		} else {
			$data['products'] = array();
			$data['categories'] = array();
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}
		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('extension/module/products_from_cat.tpl', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/products_from_cat')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if ((utf8_strlen($this->request->post['title']) < 3) || (utf8_strlen($this->request->post['title']) > 64)) {
			$this->error['title'] = $this->language->get('error_title');
		}

		if (!$this->request->post['width']) {
			$this->error['width'] = $this->language->get('error_width');
		}

		if (!$this->request->post['height']) {
			$this->error['height'] = $this->language->get('error_height');
		}

		if (!$this->request->post['limit']) {
			$this->error['limit'] = $this->language->get('error_limit');
		}

		return !$this->error;
	}
}
?>