<?php
class ModelExtensionShippingNovaPoshta extends Model {
	public function __construct($registry) {
     	parent::__construct($registry);
     	
     	require_once(DIR_SYSTEM . 'helper/novaposhta.php');

     	$registry->set('novaposhta', new NovaPoshta($registry));
    }
    
	function getQuote($address) {
		$this->load->language('extension/shipping/novaposhta');
		
		$method_data		= array();
		$quote_data 		= array();
		$shipping_methods 	= $this->config->get('novaposhta_shipping_methods');
		$products 			= $this->cart->getProducts();
		$total 				= $this->currency->convert($this->getTotal($products), $this->config->get('config_currency'), 'UAH');
		$weight 			= $this->novaposhta->getWeight($products);
		
		$this->session->data['shippingdata']['cart_weight'] = $weight;
					
		if ($this->config->get('novaposhta_calculate_volume')) {
			$volume_weight = $this->novaposhta->getVolume($products) * 250;
		} else {
			$volume_weight = 0;
		}
					
		if (!empty($address['city'])) {
			$recipient_city_ref = $this->novaposhta->getCityRef($address['city']);
		} else {
			$recipient_city_ref = '';
		}
		
		if (is_array($shipping_methods)) {
		    foreach ($shipping_methods as $code => $method) {
				if (!$method['status']) {
					continue;
				}
				
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$method['geo_zone_id'] . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
				
				if ($method['geo_zone_id'] && !$query->num_rows) {
					$status = false;
				} elseif ($total < $method['minimum_order_amount']) {
					$status = false;
				} elseif ($method['maximum_order_amount'] && $total > $method['maximum_order_amount']) {
					$status = false;
				} else {
					$status = true;
				}
				
				if ($status) {
					$cost			= 0;
					$period			= 0;
					$description 	= $method['name_' . $this->config->get('config_language_id')] ? $method['name_' . $this->config->get('config_language_id')] : $this->language->get('text_description_' . $code);
					$img 			= '';

					// Cost	
					if ($method['cost'] && (!$method['free_shipping'] || $total < $method['free_shipping'])) {
						if ($method['api_calculation'] && $recipient_city_ref && $weight) {
							$properties_cost = array (
								'Sender'		=> $this->config->get('novaposhta_sender'),
								'CitySender'	=> $this->config->get('novaposhta_sender_city'),
								'CityRecipient'	=> $recipient_city_ref,
								'ServiceType'	=> $this->config->get('novaposhta_sender_address_type') . $code,
								'Weight'		=> $weight,
								'VolumeWeight'	=> $volume_weight,
								'Cost'			=> $total,
								'DateTime' 		=> date('d.m.Y')
							);
								
							$cost = $this->novaposhta->getDocumentPrice($properties_cost);
						}

						if ($method['tariff_calculation'] && !$cost) {
							$cost = $this->tariffCalculation($this->config->get('novaposhta_sender_address_type') . $code, $total, $weight, $volume_weight);
						}
									
						// Currency correcting
						$currency_value = $this->currency->getValue('UAH');
							
						if ($cost && $currency_value != 1) {
							$cost /= $currency_value;
						}
					}

					// Period
					if ($method['delivery_period'] && $recipient_city_ref) {				
						$properties_period = array (
							'CitySender'	=> $this->config->get('novaposhta_sender_city'),
							'CityRecipient'	=> $recipient_city_ref,
							'ServiceType'	=> $this->config->get('novaposhta_sender_address_type') . $code,
							'DateTime' 		=> date('d.m.Y')
						);
								
						$period = $this->novaposhta->getDocumentDeliveryDate($properties_period);
					}
					
					// Image
					if ($this->config->get('novaposhta_image')) {
						if ($this->config->get('novaposhta_image_output_place') == 'img_key') {
							$img = HTTP_SERVER . 'image/' . $this->config->get('novaposhta_image');
						}
					}
					
					// Text
					if ($cost) {
						$text = $this->currency->format($this->tax->calculate($cost, $method['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} elseif ($method['free_shipping'] && $total >= $method['free_shipping']) {
						$text = $this->config->get('novaposhta_free_cost_text_' . $this->config->get('config_language_id'));
					} else {
						$text = '';
					}
					
					// Period
					if ($period) {
						$text_period = $this->language->get('text_period') . $this->plural_tool($period, array($this->language->get('text_day_1'), $this->language->get('text_day_2'), $this->language->get('text_day_3')));
					} else {
						$text_period = '';
					}
												
					$quote_data[$code] = array(
						'code'			=> 'novaposhta.' . $code,
						'title'			=> $description,
						'img'			=> $img,
						'cost'			=> $cost,
						'tax_class_id'	=> $method['tax_class_id'],
						'text'			=> $text,
						'text_period'	=> $text_period
					);
				}
			}	
		}
		
		if ($this->config->get('novaposhta_image') && $this->config->get('novaposhta_image_output_place') == 'title') {
			$title = '<img src="' . HTTP_SERVER . 'image/' . $this->config->get('novaposhta_image') . '" width="36" height="36" border="0" style="display:inline-block;margin:3px;">'. $this->language->get('text_title');
		} else {
			$title = $this->language->get('text_title');
		}
		
		$method_data = array(
			'code'       => 'novaposhta',
			'title'      => $title,
			'quote'      => $quote_data,
			'sort_order' => $this->config->get('novaposhta_sort_order'),
			'error'      => false
		);

		return $method_data;
	}
	
	private function getTotal($products) {
		$total = 0;
		$totals = array();
		$taxes = $this->cart->getTaxes();
		
		$total_data = array(
			'totals' => &$totals,
			'taxes'  => &$taxes,
			'total'  => &$total
		);

		foreach ($products as $product) {
			$total += $product['total'];
		}
		
		if (isset($this->session->data['coupon'])) {
			$this->load->model('extension/total/coupon');
			
			$this->model_extension_total_coupon->getTotal($total_data);			
		}
		
		if (isset($this->session->data['voucher'])) {
			$this->load->model('extension/total/voucher');
			
			$this->model_extension_total_voucher->getTotal($total_data);
		}
		
		if (isset($this->session->data['card'])) {
			$this->load->model('extension/total/membership_card');
			
			$this->model_extension_total_membership_card->getTotal($total_data);
		}

		return $total;
	}
	
	private function tariffCalculation($service_type, $total, $weight, $volume_weight) {
		$cost 			= 35;
		$services 		= array ('DoorsDoors', 'DoorsWarehouse', 'WarehouseDoors', 'WarehouseWarehouse');
		$service_type	= in_array($service_type, $services) ? $service_type : 'WarehouseWarehouse';
		$tariff_type	= 'parcel';
		$tariff_zone	= 'Ukraine';
		$tariffs		= $this->config->get('novaposhta_tariffs');
		
		if ($volume_weight > $weight) {
			$weight = $volume_weight;
		}

		if (isset($tariffs[$tariff_type]['tariffs'])) {
			foreach($tariffs[$tariff_type]['tariffs'] as $tariff) {
				if ($weight <= $tariff['weight']) {
					$cost = $tariff[$tariff_zone];
					
					break;
				}
			}
		}
		
		if ($service_type == 'DoorsWarehouse' || $service_type == 'WarehouseDoors') {
			$cost += $tariffs[$tariff_type]['overpay_doors_warehouse'];
		} elseif ($service_type == 'DoorsDoors') {
			$cost += $tariffs[$tariff_type]['overpay_doors_doors'];
		}
		
		if ($tariffs['additional_commission'] && $total > $tariffs['additional_commission_bottom']) {
			$cost += $total * $tariffs['additional_commission'] / 100;
		}
		
		if ($tariffs['discount']) {
			$cost -= $cost * $tariffs['discount'] / 100;
		}
		
		return round($cost);
	}
	
	protected function plural_tool($number, $text) {
		$cases = array (2, 0, 1, 1, 1, 2);
		
		return $number . ' ' . $text[(($number % 100) > 4 && ($number % 100) < 20) ? 2 : $cases[min($number % 10, 5)]];
    }
}