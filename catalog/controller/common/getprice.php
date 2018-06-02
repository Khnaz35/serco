<?php 
class ControllerCommonGetprice extends Controller { 
	private $error = array();
	
    public function index() {
		$this->language->load('common/getprice');	
        
            $data['title_getprice'] = $this->language->get('title_getprice');
            $data['no_product_error'] = $this->language->get('no_product_error');
        
        if (isset($_GET['product_id'])) {
            $product_id = $_GET['product_id'];
            
            $this->load->model('catalog/product');
            
            $product_info = $this->model_catalog_product->getProduct($product_id);
            
            if ($product_info) {
                $data['product_id'] = $product_id;
                $data['product_name'] = $product_info['name'];
                $data['product_link'] = $this->url->link('product/product', '&product_id=' . $this->request->get['product_id']);
            }
            else {
                $data['product_id'] = 'empty';
                $data['product_name'] = 'empty';
                $data['product_link'] = '#empty';
            }
            
            $data['text_before_button_send'] = sprintf($this->language->get('text_before_button_send'), $data['product_name']);
            $data['button_send'] = $this->language->get('button_send');
            $data['text_email_buyer'] = $this->language->get('text_email_buyer');
            
            $this->response->setOutput($this->load->view('common/getprice', $data));
        }
        else {
            
            if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['action'])) {
    					
                $json = array();
                
    			if ($this->validate()) {
                    $data = array();
                    $data['store_name'] = $this->config->get('config_name');
                        
                    if (isset($this->request->post['email_buyer'])) {
                        $data['email_buyer'] = $this->request->post['email_buyer'];
                    } 
                    else {
                        $data['email_buyer'] = '';
          			}
                        
                    if (isset($this->request->post['product_id'])) {
                        $product_id = $this->request->post['product_id'];
                        
                        $this->load->model('catalog/product');
                        
                        $product_info = $this->model_catalog_product->getProduct($product_id);
                        
                        if ($product_info) {
                            $data['product_name'] = $product_info['name'];
                            $data['product_link'] = $this->url->link('product/product', '&product_id=' . $product_id);
                        }
                        else {
                            $data['product_name'] = 'empty';
                            $data['product_link'] = '#empty';
                        }
                                    
                        $data['title_getprice'] = $this->language->get('title_getprice');
                        $data['text_email_buyer'] = $this->language->get('text_email_buyer');
                        
                        $json['success'] = $this->language->get('text_ok');
                    
                        $this->sendMailMe($data);
                        
                    } 
                    else {
                        $json['error']['product_id_error'] = $this->language->get('no_product_error');
          			}
                      
                } else {
    				$json['error'] = $this->error;
    				
    			}
        
                return $this->response->setOutput(json_encode($json));
    		}
            $this->response->setOutput($this->load->view('common/getprice_empty', $data));
        }
  	}

  	private function validate() {
   		$this->language->load('common/getprice');
        
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
   		$this->language->load('common/getprice');
        
        $subject = $this->language->get('subject');
        
        $html = '';
        $html .= $this->load->view('mail/getprice', $data);
        
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
		$mail->smtp_username = $this->config->get('config_mail_smtp_username');
		$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$mail->smtp_port = $this->config->get('config_mail_smtp_port');
		$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

		$mail->setTo($this->config->get('config_email'));
        //$mail->setFrom($this->config->get('config_email'));
        $mail->setFrom('getprice@cotti.cybersov.net'); // deltoro1985@mail.ru
        
		$mail->setSender(html_entity_decode($data['store_name'], ENT_QUOTES, 'UTF-8'));
		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
		$mail->setHtml(html_entity_decode($html, ENT_QUOTES, 'UTF-8'));
		$mail->setText($subject);
		$mail->send();
	}	
}