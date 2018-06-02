<?php 
class ControllerCommonGetcatalog extends Controller { 
	private $error = array();
	
    public function index() {
		$this->language->load('common/getcatalog');	
        
        $data['title_getcatalog'] = $this->language->get('title_getcatalog');
        $data['text_email_buyer'] = $this->language->get('text_email_buyer');
        $data['button_send'] = $this->language->get('button_send');
        $data['text_before_button_send'] = $this->language->get('text_before_button_send');
        $text_ok = $this->language->get('text_ok');
        
        $this->language->load('common/getcatalog');

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['action'])) {
					
            $json = array();
            
			if ($this->validate()) {
				$data = array();
				$data['store_name'] = $this->config->get('config_name');
                
				if (isset($this->request->post['email_buyer'])) {
      				$data['email_buyer'] = $this->request->post['email_buyer'];
				} else {
      				$data['email_buyer'] = '';
    			}
                
                $data['title_getcatalog'] = $this->language->get('title_getcatalog');
                $data['text_email_buyer'] = $this->language->get('text_email_buyer');
                
				//$json['success'] = $this->language->get('ok');
				$json['success'] = $text_ok;
                
				$this->sendMailMe($data);	
                
			} else {
				$json['error'] = $this->error;
				
			}
			
			return $this->response->setOutput(json_encode($json));
		}
        
		$this->response->setOutput($this->load->view('common/getcatalog', $data));
  	}

  	private function validate() {
   		$this->language->load('common/getcatalog');
        
        if(!preg_match("/^([a-z0-9_\.-]+)@([a-z0-9_\.-]+)\.([a-z\.]{2,6})$/", $this->request->post['email_buyer'])){
            $this->error['email_error'] =  $this->language->get('email_buyer_error');
        }
            
 		if (!$this->error) {
            return true;
 		} 
         else {
            return false;
   	 	}
	}
    
  	private function sendMailMe($data) {
   		$this->language->load('common/getcatalog');
        
        $subject = $this->language->get('subject');
        
        $html = '';
        $html .= $this->load->view('mail/getcatalog', $data);
        
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setTo($this->config->get('config_email'));
        $mail->setFrom($this->config->get('config_email'));
        
		$mail->setSender(html_entity_decode($data['store_name'], ENT_QUOTES, 'UTF-8'));
		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
		$mail->setHtml(html_entity_decode($html, ENT_QUOTES, 'UTF-8'));
		$mail->setText($subject);
		$mail->send();
	}	
}