<?php
class ModelExtensionTotalPrivat24Fee extends Model {
	public function getTotal($total) {
		if (isset($this->session->data['payment_method']) && ($this->session->data['payment_method']['code'] == 'privat24')) {
			$this->load->language('extension/total/privat24_fee');
			
			$percentsSign = '';
			
			if ($this->config->get('privat24_fee_percents') == 1) {
				$privat24_fee_fee = ($this->cart->getSubTotal() / 100) * $this->config->get('privat24_fee_fee');
				$percentsSign = '%';
			} else {
				$privat24_fee_fee = $this->config->get('privat24_fee_fee');
			}
			
			$title = ($this->config->get('privat24_fee_custom_title')) ? $this->config->get('privat24_fee_custom_title') : $this->language->get('text_title');
			
			$total['totals'][] = array(
				'code'       => 'privat24_fee',
				'title'      => $title.sprintf($this->language->get('text_privat24_fee_amount'), $this->config->get('privat24_fee_fee').$percentsSign),
				'value'      => $privat24_fee_fee,
				'sort_order' => $this->config->get('privat24_fee_sort_order')
			);
			
			if ($this->config->get('privat24_fee_tax_class_id')) {
				$tax_rates = $this->tax->getRates($privat24_fee_fee, $this->config->get('privat24_fee_tax_class_id'));
				
				foreach ($tax_rates as $tax_rate) {
					if (!isset($total['taxes'][$tax_rate['tax_rate_id']])) {
						$total['taxes'][$tax_rate['tax_rate_id']] = $tax_rate['amount'];
					} else {
						$total['taxes'][$tax_rate['tax_rate_id']] += $tax_rate['amount'];
					}
				}
			}
			
			$total['total'] += $privat24_fee_fee;
		}
	}
}