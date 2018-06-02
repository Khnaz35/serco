<?php
class ControllerInformationInformation extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');
        
                $data['galery_diplom'] = $this->load->controller('information/galery_diplom');
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
        
        $data['contact_form_on'] = 0;
        
        if ($information_id != 4) {
        $this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
        $this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
        $this->document->addScript('catalog/view/javascript/sendform.js');
        
        $data['contact_form_on'] = 1;
        $data['title_sendform'] = $this->language->get('title_sendform');
        $data['text_before_button_send'] = $this->language->get('text_before_button_send');
        $data['text_name_buyer'] = $this->language->get('text_name_buyer');
        $data['text_phone_buyer'] = $this->language->get('text_phone_buyer');
        $data['text_email_buyer'] = $this->language->get('text_email_buyer');
        $data['text_comment_buyer'] = $this->language->get('text_comment_buyer');
        $data['button_send'] = $this->language->get('button_send');
        $text_ok = $this->language->get('text_ok');

        // Форма обратной связи
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['action'])) {

            $json = array();
            $has_error = false;
            
            if (strlen(utf8_decode($this->request->post['bot_catcher'])) > 0) {
                $has_error = true;
                $json['warning']['bot_catcher'] = $this->language->get('error_bot_catcher');
            }
            if (strlen(utf8_decode($this->request->post['name_buyer'])) < 1) {
                $has_error = true;
                $json['warning']['name'] = $this->language->get('error_name_buyer');
            }
    		if (strlen(utf8_decode($this->request->post['phone_buyer'])) < 19) {
                $has_error = true;
                $json['warning']['phone'] = $this->language->get('error_phone_buyer');
            } 
            
            
            if (!$has_error){
                $data = array();
                
                if (isset($this->request->post['page_name'])) {
                    $data['page_name'] = $this->request->post['page_name'];
                } else {
                    $data['page_name'] = '-';
                }
                    
                if (isset($this->request->post['name_buyer'])) {
                    $data['name_buyer'] = $this->request->post['name_buyer'];
                } else {
                    $data['name_buyer'] = '';
                }
                
                if (isset($this->request->post['phone_buyer'])) {
                    $data['phone_buyer'] = $this->request->post['phone_buyer'];
                } else {
                    $data['phone_buyer'] = '';
                }
                
                if (isset($this->request->post['email_buyer'])) {
                    $data['email_buyer'] = $this->request->post['email_buyer'];
                } else {
                    $data['email_buyer'] = 'nomail@cotti.cybersov.net';
                }
                if (isset($this->request->post['comment_buyer'])) {
                    $data['comment_buyer'] = $this->request->post['comment_buyer'];
                } else {
                    $data['comment_buyer'] = '';
                }
                
                $data['text_page'] = $this->language->get('text_page');
                $data['text_name_buyer'] = $this->language->get('text_name_buyer');
                $data['text_phone_buyer'] = $this->language->get('text_phone_buyer');
                $data['text_email_buyer'] = $this->language->get('text_email_buyer');
                $data['text_comment_buyer'] = $this->language->get('text_comment_buyer');
                        
                $this->sendMailMe($data);
                
                $json['success'] = $this->language->get('text_ok');
            }
            
            return $this->response->setOutput(json_encode($json));
        }
        }



		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
            
            // страница Магазины
            $data['shoplists'] = false;
            if ($information_id == 11) {
                $this->load->model('catalog/shoplist');
                $results = $this->model_catalog_shoplist->getShoplists();
                if ($results){
                    
                    $data['text_shop_address'] = $this->language->get('text_shop_address');
                    $data['text_shop_phone'] = $this->language->get('text_shop_phone');
                    $data['text_shop_email'] = $this->language->get('text_shop_email');
                    $data['text_shop_workingtime'] = $this->language->get('text_shop_workingtime');
                    
                    foreach ($results as $result){
                        $data['shoplists'][] = array(
            				'shoplist_id'    => $result['shoplist_id'],
            				'title'          => $result['title'],
            				'description'    => html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
            				'address'        => nl2br($result['address']),
            				'phone'          => nl2br($result['phone']),
            				'email'          => nl2br($result['email']),
            				'workingtime'    => nl2br($result['workingtime']),
            				'googlemap'      => html_entity_decode($result['googlemap'], ENT_QUOTES, 'UTF-8'),
            				'sort_order'     => $result['sort_order']
            			);
                    }
                }
            }
            
            // страница Контакты
            $data['googlemap'] = false;
            if ($information_id == 8) {
                $data['googlemap'] = html_entity_decode($this->config->get('config_geocode'), ENT_QUOTES, 'UTF-8');
            }
            
            
			if ($information_info['meta_title']) {
				$this->document->setTitle($information_info['meta_title']);
			} else {
				$this->document->setTitle($information_info['title']);
			}

			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);

			if ($information_info['meta_h1']) {
				$data['heading_title'] = $information_info['meta_h1'];
			} else {
				$data['heading_title'] = $information_info['title'];
			}

			$data['button_continue'] = $this->language->get('button_continue');

			$data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('information/information', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
    
  	private function sendMailMe($data) {
   		$this->language->load('information/information');
        
        $subject = $this->language->get('subject');
        
        $html = '';
        $html .= $this->load->view('mail/contactform', $data);
        
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
        
		$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
		$mail->setHtml(html_entity_decode($html, ENT_QUOTES, 'UTF-8'));
		$mail->setText($subject);
		$mail->send();
	}
}