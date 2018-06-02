<?php
class ControllerExtensionModuleNewsletters extends Controller{
	public function index(){

        //$this->document->addStyle('catalog/view/theme/cybershark/stylesheet/newsletters.css');
        $this->document->addScript('catalog/view/javascript/newsletters.js');

		$this->load->language('extension/module/newsletters');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['entry_submit'] = $this->language->get('entry_submit');
		$data['button_submit'] = $this->language->get('button_submit');

		return $this->load->view('extension/module/newsletters', $data);
	}

	public function newSubscribe(){
		$this->load->model('extension/module/newsletters');

		$json = array();
		$json['message'] = $this->model_extension_module_newsletters->subscribes($this->request->post);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}