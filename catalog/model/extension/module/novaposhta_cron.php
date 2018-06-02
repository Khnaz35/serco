<?php
class ModelExtensionModuleNovaPoshtaCron extends Model {	
	public function getOrders() {
		$result = $this->db->query("SELECT `o`.*, `l`.`code`, `l`.`directory`, CONCAT(`c`.`firstname`, ' ', `c`.`lastname`) as `customer` FROM `" . DB_PREFIX . "order` as `o` LEFT JOIN `" . DB_PREFIX . "language` as `l` ON (`l`.`language_id` = `o`.`language_id`) LEFT JOIN `" . DB_PREFIX . "customer` as `c` ON (`c`.`customer_id` = `o`.`customer_id`)  WHERE `order_status_id` IN (" . implode(',', $this->config->get('novaposhta_tracking_statuses')) . ") AND `novaposhta_ei_number` != ''");
		
		return $result;
	}
	
	public function getProducts($order_id) {
		$result = $this->db->query("SELECT `op`.`product_id`, `op`.`name`, `op`.`model`, `op`.`quantity`, `p`.`sku`, `p`.`weight` * `op`.`quantity` as `weight`, `p`.`weight_class_id`, `p`.`length`, `p`.`width`, `p`.`height`, `p`.`length_class_id` FROM `" . DB_PREFIX . "order_product` AS `op` INNER JOIN `" . DB_PREFIX . "product` AS `p` ON `op`.`product_id` = `p`.`product_id` AND `op`.`order_id` = " . (int) $order_id)->rows;
		
		return $result;
	}
	
	public function getSimpleFields($order_id) {
		$data = array();
		
		$table = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "order_simple_fields'")->row;
		
		if ($table) {
			$data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_simple_fields` WHERE `order_id` = '" . (int) $order_id . "'")->row;
		}
		
		return $data;
	}
}