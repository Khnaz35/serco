<?php
class ControllerInformationGaleryDiplom extends Controller {

    public function index() {
        if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}
    $data['base'] = $server;

    
  return $this->load->view('information/galery_diplom', $data);
    
 // $this->response->setOutput($this->load->view('information/information', $data));
     
}
    
}

