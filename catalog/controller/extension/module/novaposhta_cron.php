<?php
class ControllerExtensionModuleNovaPoshtaCron extends Controller {
	public function update() {
		if (isset($this->request->get['type'], $this->request->get['key']) && $this->request->get['key'] == $this->config->get('novaposhta_key_cron')) {			
		require_once(DIR_SYSTEM . 'helper/novaposhta.php');
					
		$novaposhta = new NovaPoshta($this->registry);
		
		$novaposhta->update($this->request->get['type']);
		}
	}
	
	public function departuresTracking() {
		if (isset($this->request->get['key']) && $this->request->get['key'] == $this->config->get('novaposhta_key_cron')) {
			require_once(DIR_SYSTEM . 'helper/novaposhta.php');
						
			$novaposhta = new NovaPoshta($this->registry);
			
			$this->load->model('extension/module/novaposhta_cron');
			
			// Start caching orders for tracking if there are more than $limit
			$limit 	= 100;
			
			$data = $this->cache->get('novaposhta_tracking_orders');
			
			if ($data) {
				$orders = array_splice($data, 0, $limit);
				
				if ($data) {
					$this->cache->set('novaposhta_tracking_orders', $data);
				} else {
					$this->cache->delete('novaposhta_tracking_orders');
				}
				
			} else {
				$result = $this->model_extension_module_novaposhta_cron->getOrders();

				if ($result->num_rows > $limit) {
					$data 	= $result->rows;
					
					$orders = array_splice($data, 0, $limit);
					
					$this->cache->set('novaposhta_tracking_orders', $data);
				} else {
					$orders = $result->rows;
				}
			}

			if ($orders) {
				$ei_numbers = array();
				
				$find_order = array(
					'{order_id}',
					'{invoice}',
					'{store_name}',
					'{store_url}',
					'{name}',
					'{shipping_name}',
					'{date_added}',
					'{date_modified}',
					'{customer}',                
					'{firstname}',              
					'{lastname}',                
					'{email}',                  
					'{telephone}',               
					'{fax}',                    
					'{payment_firstname}',       
					'{payment_lastname}',        
					'{payment_company}',         
					'{payment_address_1}',       
					'{payment_address_2}',       
					'{payment_postcode}',        
					'{payment_city}',            
					'{payment_zone}',           
					'{payment_country}',         
					'{shipping_firstname}',      
					'{shipping_lastname}',       
					'{shipping_company}',        
					'{shipping_address_1}',      
					'{shipping_address_2}',      
					'{shipping_postcode}',       
					'{shipping_city}',          
					'{shipping_zone}',           
					'{shipping_country}'
				);
				
				$find_product = array(
					'{product_name}',
					'{model}',
					'{sku}',
					'{quantity}'
				);
					
				$find_ei = array(
					'{Number}',
					'{Redelivery}',
					'{RedeliverySum}',
					'{RedeliveryNum}',
					'{RedeliveryPayer}',
					'{OwnerDocumentType}',
					'{LastCreatedOnTheBasisDocumentType}',
					'{LastCreatedOnTheBasisPayerType}',
					'{LastCreatedOnTheBasisDateTime}',
					'{LastTransactionStatusGM}',
					'{LastTransactionDateTimeGM}',
					'{DateCreated}',
					'{DocumentWeight}',
					'{CheckWeight}',
					'{DocumentCost}',
					'{SumBeforeCheckWeight}',
					'{PayerType}',
					'{RecipientFullName}',
					'{RecipientDateTime}',
					'{ScheduledDeliveryDate}',
					'{PaymentMethod}',
					'{CargoDescriptionString}',
					'{CargoType}',
					'{CitySender}',
					'{CityRecipient}',
					'{WarehouseRecipient}',
					'{CounterpartyType}',
					'{AfterpaymentOnGoodsCost}',
					'{ServiceType}',
					'{UndeliveryReasonsSubtypeDescription}',
					'{WarehouseRecipientNumber}',
					'{LastCreatedOnTheBasisNumber}',
					'{Status}',
					'{StatusCode}'
				);
				
				foreach ($orders as $k => $order) {
					$replace_order[$order['order_id']] = array(
						'order_id'				=> $order['order_id'],
						'invoice'				=> $order['invoice_prefix'] . $order['invoice_no'],
						'store_name'			=> $order['store_name'],
						'store_url'				=> $order['store_url'],
						'name'					=> $order['lastname'] . ' ' . $order['firstname'],
						'shipping_name'			=> $order['shipping_lastname'] . ' ' . $order['shipping_firstname'],
						'date_added'			=> $order['date_added'],
						'date_modified'			=> $order['date_modified'],
						'customer'   			=> $order['customer'],             
						'firstname'				=> $order['firstname'], 
						'lastname'				=> $order['lastname'], 
						'email'					=> $order['email'], 
						'telephone'				=> $order['telephone'],               
						'fax'					=> $order['fax'],                    
						'payment_firstname'		=> $order['payment_firstname'],       
						'payment_lastname'		=> $order['payment_lastname'],        
						'payment_company'		=> $order['payment_company'],         
						'payment_address_1'		=> $order['payment_address_1'],       
						'payment_address_2'		=> $order['payment_address_2'],       
						'payment_postcode'		=> $order['payment_postcode'],        
						'payment_city'			=> $order['payment_city'],            
						'payment_zone'			=> $order['payment_zone'],           
						'payment_country'		=> $order['payment_country'],         
						'shipping_firstname'	=> $order['shipping_firstname'],      
						'shipping_lastname'		=> $order['shipping_lastname'],       
						'shipping_company'		=> $order['shipping_company'],        
						'shipping_address_1'	=> $order['shipping_address_1'],      
						'shipping_address_2'	=> $order['shipping_address_2'],      
						'shipping_postcode'		=> $order['shipping_postcode'],       
						'shipping_city'			=> $order['shipping_city'],          
						'shipping_zone'			=> $order['shipping_zone'],           
						'shipping_country'		=> $order['shipping_country']
					);
					
					foreach ($this->model_extension_module_novaposhta_cron->getSimpleFields($order['order_id']) as $k => $v) {
						if (!in_array('{' . $k . '}', $find_order)) {
							$find_order[]      = '{' . $k . '}';
							$replace_order[$order['order_id']][$k] = $v;	
						}
					}

					$ei_numbers[] = array(
						'DocumentNumber' => $order['novaposhta_ei_number'],
						'Phone' 		 => preg_replace('/[^0-9]/', '', trim(str_replace($find_order, $replace_order[$order['order_id']], $this->config->get('novaposhta_recipient_contact_person_phone'))))
					);

					$orders[$order['novaposhta_ei_number']] = $order;
					
					unset($orders[$k]);
				}
				
				$documents = $novaposhta->tracking($ei_numbers);

				if ($documents) {
					$tracking_settings = $this->config->get('novaposhta_settings_tracking_statuses');

					foreach($documents as $document){
						if (   $document['Number'] 
							&& isset($tracking_settings[$document['StatusCode']])
							&& $tracking_settings[$document['StatusCode']]['store'] != $orders[$document['Number']]['order_status_id']
						) {
							// Message
							$message = '';
							$template = explode('|', $tracking_settings[$document['StatusCode']]['message']);
							
							if ($template[0]) {
								$replace_ei = array(
									'Number' 								=> $document['Number'],
									'Redelivery' 							=> $document['Redelivery'],
									'RedeliverySum' 						=> $document['RedeliverySum'],
									'RedeliveryNum' 						=> $document['RedeliveryNum'],
									'RedeliveryPayer' 						=> $document['RedeliveryPayer'],
									'OwnerDocumentType' 					=> $document['OwnerDocumentType'],
									'LastCreatedOnTheBasisDocumentType'		=> $document['LastCreatedOnTheBasisDocumentType'],
									'LastCreatedOnTheBasisPayerType'	 	=> $document['LastCreatedOnTheBasisPayerType'],
									'LastCreatedOnTheBasisDateTime' 		=> $document['LastCreatedOnTheBasisDateTime'],
									'LastTransactionStatusGM' 				=> $document['LastTransactionStatusGM'],
									'LastTransactionDateTimeGM' 			=> $document['LastTransactionDateTimeGM'],
									'DateCreated' 							=> $document['DateCreated'],
									'DocumentWeight' 						=> $document['DocumentWeight'],
									'CheckWeight' 							=> $document['CheckWeight'],
									'DocumentCost' 							=> $document['DocumentCost'],
									'SumBeforeCheckWeight' 					=> $document['SumBeforeCheckWeight'],
									'PayerType' 							=> $document['PayerType'],
									'RecipientFullName' 					=> $document['RecipientFullName'],
									'RecipientDateTime' 					=> $document['RecipientDateTime'],
									'ScheduledDeliveryDate' 				=> $document['ScheduledDeliveryDate'],
									'PaymentMethod' 						=> $document['PaymentMethod'],
									'CargoDescriptionString'	 			=> $document['CargoDescriptionString'],
									'CargoType' 							=> $document['CargoType'],
									'CitySender' 							=> $document['CitySender'],
									'CityRecipient' 						=> $document['CityRecipient'],
									'WarehouseRecipient' 					=> $document['WarehouseRecipient'],
									'CounterpartyType' 						=> $document['CounterpartyType'],
									'AfterpaymentOnGoodsCost' 				=> $document['AfterpaymentOnGoodsCost'],
									'ServiceType'							=> $document['ServiceType'],
									'UndeliveryReasonsSubtypeDescription'	=> $document['UndeliveryReasonsSubtypeDescription'],
									'WarehouseRecipientNumber' 				=> $document['WarehouseRecipientNumber'],
									'LastCreatedOnTheBasisNumber' 			=> $document['LastCreatedOnTheBasisNumber'],
									'Status' 								=> $document['Status'],
									'StatusCode' 							=> $document['StatusCode']
								);
								
								$message = trim(str_replace($find_order, $replace_order[$orders[$document['Number']]['order_id']], $template[0]));
								$message = str_replace($find_ei, $replace_ei, $message);
							}
							
							if (isset($template[1])) {
								$products = $this->model_extension_module_novaposhta_cron->getProducts($orders[$document['Number']]['order_id']);

								foreach ($products as $k => $product) {
									$replace_product = array(
										'name'		=> $product['name'],
										'model'		=> $product['model'],
										'sku'		=> $product['sku'],
										'quantity'	=> $product['quantity']
									);
									
									$message .= trim(str_replace($find_product, $replace_product, $template[1]));
								}
							}
							
							// Add order history
							$notify = (isset($tracking_settings[$document['StatusCode']]['customer_notification'])) ? true : false;
							
							$this->load->model('checkout/order');
							
							$this->model_checkout_order->addOrderHistory($orders[$document['Number']]['order_id'], $tracking_settings[$document['StatusCode']]['store'], $message, $notify);
							
							// Customer notification
							if (isset($tracking_settings[$document['StatusCode']]['customer_notification']) && $orders[$document['Number']]['email']) {
								$language_directory = 'code';

								$language = new Language($orders[$document['Number']][$language_directory]);
								$language->load($orders[$document['Number']][$language_directory]);
								$language->load('mail/order');

								$subject = sprintf($language->get('text_update_subject'), html_entity_decode($orders[$document['Number']]['store_name'], ENT_QUOTES, 'UTF-8'), $orders[$document['Number']]['order_id']);

								$mail = new Mail();
								$mail->protocol = $this->config->get('config_mail_protocol');
								$mail->parameter = $this->config->get('config_mail_parameter');
								$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
								$mail->smtp_username = $this->config->get('config_mail_smtp_username');
								$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
								$mail->smtp_port = $this->config->get('config_mail_smtp_port');
								$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

								$mail->setTo($orders[$document['Number']]['email']);
								$mail->setFrom($this->config->get('config_email'));
								$mail->setSender(html_entity_decode($orders[$document['Number']]['store_name'], ENT_QUOTES, 'UTF-8'));
								$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
								$mail->setHtml(html_entity_decode($message));
								$mail->send();	
							}
							
							// Admin notification
							if (isset($tracking_settings[$document['StatusCode']]['admin_notification'])) {
								$language_directory = 'code';

								$language = new Language($orders[$document['Number']][$language_directory]);
								$language->load($orders[$document['Number']][$language_directory]);
								$language->load('mail/order');

								$subject = sprintf($language->get('text_update_subject'), html_entity_decode($orders[$document['Number']]['store_name'], ENT_QUOTES, 'UTF-8'), $orders[$document['Number']]['order_id']);

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
								$mail->setSender(html_entity_decode($orders[$document['Number']]['store_name'], ENT_QUOTES, 'UTF-8'));
								$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
								$mail->setHtml(html_entity_decode($message));
								$mail->send();	
								
								// Send to additional alert emails
								$emails = explode(',', $this->config->get('config_mail_alert'));

								foreach ($emails as $email) {
									if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
										$mail->setTo($email);
										$mail->send();
									}
								}
							}
						}
					}
				}
			}
		}
	}
}