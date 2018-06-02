<?php
class ControllerExtensionPaymentPrivat24 extends Controller {
	private $error = array();
	
	public function index() {
		$this->load->language('extension/payment/privat24');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('privat24', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['entry_merchant_id'] = $this->language->get('entry_merchant_id');
		$data['entry_secret_key'] = $this->language->get('entry_secret_key');
		$data['entry_currency'] = $this->language->get('entry_currency');
		$data['entry_server_url'] = $this->language->get('entry_server_url');
		$data['entry_return_url'] = $this->language->get('entry_return_url');
		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['tab_general'] = $this->language->get('tab_general');
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['merchant_id'])) {
			$data['error_merchant_id'] = $this->error['merchant_id'];
		} else {
			$data['error_merchant_id'] = '';
		}
		
		if (isset($this->error['secret_key'])) {
			$data['error_secret_key'] = $this->error['secret_key'];
		} else {
			$data['error_secret_key'] = '';
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/payment/privat24', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/payment/privat24', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=payment', true);
		
		if (isset($this->request->post['privat24_merchant_id'])) {
			$data['privat24_merchant_id'] = $this->request->post['privat24_merchant_id'];
		} else {
			$data['privat24_merchant_id'] = $this->config->get('privat24_merchant_id');
		}
		
		if (isset($this->request->post['privat24_secret_key'])) {
			$data['privat24_secret_key'] = $this->request->post['privat24_secret_key'];
		} else {
			$data['privat24_secret_key'] = $this->config->get('privat24_secret_key');
		}
		
		$data['privat24_server_url'] = HTTP_CATALOG . 'index.php?route=payment/privat24/callback';
		$data['privat24_return_url'] = HTTP_CATALOG . 'index.php?route=payment/privat24/success';
		
		
		if (isset($this->request->post['privat24_order_status_id'])) {
			$data['privat24_order_status_id'] = $this->request->post['privat24_order_status_id'];
		} else {
			$data['privat24_order_status_id'] = $this->config->get('privat24_order_status_id'); 
		}
		
		$this->load->model('localisation/currency');
		$data['currencies'] = $this->model_localisation_currency->getCurrencies();
		
		if (isset($this->request->post['privat24_currency'])) {
			$data['privat24_currency'] = $this->request->post['privat24_currency'];
		} else {
			$data['privat24_currency'] = $this->config->get('privat24_currency');
		}
		
		$this->load->model('localisation/order_status');
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['privat24_geo_zone_id'])) {
			$data['privat24_geo_zone_id'] = $this->request->post['privat24_geo_zone_id'];
		} else {
			$data['privat24_geo_zone_id'] = $this->config->get('privat24_geo_zone_id'); 
		}
		
		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['privat24_status'])) {
			$data['privat24_status'] = $this->request->post['privat24_status'];
		} else {
			$data['privat24_status'] = $this->config->get('privat24_status');
		}
		
		if (isset($this->request->post['privat24_sort_order'])) {
			$data['privat24_sort_order'] = $this->request->post['privat24_sort_order'];
		} else {
			$data['privat24_sort_order'] = $this->config->get('privat24_sort_order');
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('extension/payment/privat24.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/payment/privat24')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['privat24_merchant_id']) {
			$this->error['merchant_id'] = $this->language->get('error_merchant_id');
		}
		
		if (!$this->request->post['privat24_secret_key']) {
			$this->error['secret_key'] = $this->language->get('error_secret_key');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}