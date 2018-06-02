<?php
class ControllerExtensionModulenewsletters extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/newsletters');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module/newsletters');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('newsletters', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_no_results'] = $this->language->get('text_no_results');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['token'] = $this->session->data['token'];
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/newsletters', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/newsletters', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['newsletters_status'])) {
			$data['newsletters_status'] = $this->request->post['newsletters_status'];
		} else {
			$data['newsletters_status'] = $this->config->get('newsletters_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->load->model('extension/module/newsletters');

		$data['newsletters'] = array();

		$results = $this->model_extension_module_newsletters->getNewsLetters();

		foreach ($results as $result) {
			$data['newsletters'][] = array(
				'news_id' 		=> $result['news_id'],
				'news_email' 	=> $result['news_email'],
				'news_added' 	=> date('d-m-Y', strtotime($result['news_added']))
			);
		}

		$data['column_news_email'] = $this->language->get('column_news_email');
		$data['column_news_added'] = $this->language->get('column_news_added');
		$data['column_remove'] = $this->language->get('column_remove');

		$this->response->setOutput($this->load->view('extension/module/newsletters', $data));
	}

	public function install() {
		$this->load->model('extension/module/newsletters');

		$this->model_extension_module_newsletters->install();
	}

	public function uninstall() {
		$this->load->model('extension/module/newsletters');

		$this->model_extension_module_newsletters->uninstall();
	}

	public function unsubscription(){
		$this->load->model('extension/module/newsletters');		

		if($this->model_extension_module_newsletters->unsubscription($this->request->post)){
			$json = array(
				'status' => 1,
				'message' => 'Unsubscription Successfull'
			);
			
		}else{
			$json = array(
				'status' => 0,
				'message' => 'Unsubscription Fail'
			);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/newsletters')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}