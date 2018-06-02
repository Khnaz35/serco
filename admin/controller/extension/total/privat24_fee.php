<?php
class ControllerExtensionTotalPrivat24Fee extends Controller {
	private $error = array();
	 
	public function index() {
		$this->load->language('extension/total/privat24_fee');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('privat24_fee', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=total', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_percents'] = $this->language->get('text_percents');
		
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_fee'] = $this->language->get('entry_fee');
		$data['entry_fee_help'] = $this->language->get('entry_fee_help');
		$data['entry_tax_class'] = $this->language->get('entry_tax_class');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['entry_custom_title'] = $this->language->get('entry_custom_title');
		$data['entry_custom_title_help'] = $this->language->get('entry_custom_title_help');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),      		
			'separator' => false
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_total'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=total', true),
			'separator' => ' :: '
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/total/privat24_fee', 'token=' . $this->session->data['token'], true),
			'separator' => ' :: '
		);
		
		$data['action'] = $this->url->link('extension/total/privat24_fee', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=total', true);
		
		if (isset($this->request->post['privat24_fee_fee'])) {
			$data['privat24_fee_fee'] = $this->request->post['privat24_fee_fee'];
		} else {
			$data['privat24_fee_fee'] = $this->config->get('privat24_fee_fee');
		}
		
		if (isset($this->request->post['privat24_fee_percents'])) {
			$data['privat24_fee_percents'] = $this->request->post['privat24_fee_percents'];
		} elseif ($this->config->get('privat24_fee_percents')) {
			$data['privat24_fee_percents'] = $this->config->get('privat24_fee_percents');
		} else {
			$data['privat24_fee_percents'] = 1;
		}
		
		if (isset($this->request->post['privat24_fee_tax_class_id'])) {
			$data['privat24_fee_tax_class_id'] = $this->request->post['privat24_fee_tax_class_id'];
		} else {
			$data['privat24_fee_tax_class_id'] = $this->config->get('privat24_fee_tax_class_id');
		}
		
		if (isset($this->request->post['privat24_fee_custom_title'])) {
			$data['privat24_fee_custom_title'] = $this->request->post['privat24_fee_custom_title'];
		} else {
			$data['privat24_fee_custom_title'] = $this->config->get('privat24_fee_custom_title');
		}
		
		if (isset($this->request->post['privat24_fee_status'])) {
			$data['privat24_fee_status'] = $this->request->post['privat24_fee_status'];
		} else {
			$data['privat24_fee_status'] = $this->config->get('privat24_fee_status');
		}

		if (isset($this->request->post['privat24_fee_sort_order'])) {
			$data['privat24_fee_sort_order'] = $this->request->post['privat24_fee_sort_order'];
		} else {
			$data['privat24_fee_sort_order'] = $this->config->get('privat24_fee_sort_order');
		}
		
		$this->load->model('localisation/tax_class');
		$data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/total/privat24_fee.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/total/privat24_fee')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}