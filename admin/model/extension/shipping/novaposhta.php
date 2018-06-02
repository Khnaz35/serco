<?php
class ModelExtensionShippingNovaPoshta extends Model {
	public function getOrderProducts($order_id) {
		$query = $this->db->query("SELECT `op`.`product_id`, `op`.`name`, `op`.`model`, `op`.`quantity`, `p`.`sku`, `p`.`weight` * `op`.`quantity` as `weight`, `p`.`weight_class_id`, `p`.`length`, `p`.`width`, `p`.`height`, `p`.`length_class_id` FROM `" . DB_PREFIX . "order_product` AS `op` INNER JOIN `" . DB_PREFIX . "product` AS `p` ON `op`.`product_id` = `p`.`product_id` AND `op`.`order_id` = " . $order_id);

		return $query->rows;
	}
	
	public function getOrderByDocumentNumber($number) {
		$query = $this->db->query("SELECT `order_id` FROM `" . DB_PREFIX . "order` WHERE `novaposhta_ei_number` = '" . $this->db->escape($number) . "'");

		return $query->row;
	}
	
	public function addEIToOrder($order_id, $data = array()) {
		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET `novaposhta_ei_number` = '" . $this->db->escape($data['IntDocNumber']) . "', `novaposhta_ei_ref` = '" . $this->db->escape($data['Ref']) . "' WHERE `order_id` = " . (int)$order_id);
	}
	
	public function deleteEIFromOrder($refs) {
		foreach ($refs as $k => $v) {
				$refs[$k] = "'" . $v . "'";
		}
		
		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET `novaposhta_ei_number` = '', `novaposhta_ei_ref` = '' WHERE `novaposhta_ei_ref` IN (" . implode(',', $refs) . ")");
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