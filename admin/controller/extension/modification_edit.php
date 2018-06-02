<?php
class ControllerExtensionModificationEdit extends Controller {
	public function index() {
		$this->load->language('extension/modification_edit');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/modification');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (isset($this->request->get['modification_id'])) {
				$this->model_extension_modification->editModification($this->request->get['modification_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_xml'] = $this->language->get('entry_xml');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL')
		);
		
		

		if (isset($this->request->get['modification_id'])) {
			$data['action'] = $this->url->link('extension/modification_edit', 'token=' . $this->session->data['token'] . '&modification_id=' . $this->request->get['modification_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['modification_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$modification_info = $this->model_extension_modification->getModification($this->request->get['modification_id']);
		}

		$data['modification_info'] = $modification_info;

		$data['breadcrumbs'][] = array(
			'text' => $modification_info['name'],
			'href' => $this->url->link('extension/modification', 'token=' . $this->session->data['token'] . '&modification_id=' . $this->request->get['modification_id'], 'SSL')
		);
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($modification_info)) {
			$data['name'] = $modification_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['xml'])) {
			$data['xml'] = $this->request->post['xml'];
		} elseif (!empty($modification_info)) {
			$data['xml'] = $modification_info['xml'];
		} else {
			$data['xml'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/modification_edit.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/modification')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (utf8_strlen($this->request->post['name']) < 3) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}
}