<?php
class ModelExtensionModuleShippingData extends Model {	
	public function getNovaPoshtaCities($area, $search = '') {
		$description = ($this->language->get('code') == 'uk' || $this->language->get('code') == 'ua') ? 'Description' : 'DescriptionRu';
		$area        = $this->db->escape($area);
		$search      = $this->db->escape($search);
				
		$sql = "SELECT `" . $description . "` as `Description` FROM `" . DB_PREFIX . "novaposhta_cities` WHERE `Area` = '" . $area . "'";
		
		if ($search) {
			$sql .= " AND  `" . $description . "` LIKE '" . $search . "%'";
		}
		
		$sql .= " ORDER BY  `" . $description . "`";
		
		return $this->db->query($sql)->rows;
	}
	
	public function getNovaPoshtaWarehouses($city, $search = '') {
		$description      = ($this->language->get('code') == 'uk' || $this->language->get('code') == 'ua') ? 'Description' : 'DescriptionRu';
		$city_description = ($this->language->get('code') == 'uk' || $this->language->get('code') == 'ua') ? 'CityDescription' : 'CityDescriptionRu';
		$city             = $this->db->escape($city);
		$search           = $this->db->escape($search);
				
		if (ctype_digit($search)) {
			$sql = "SELECT `" . $description . "` as `Description` FROM `" . DB_PREFIX . "novaposhta_warehouses` WHERE `" . $city_description . "` = '" . $city . "'";
			
			if ($search) {
				$sql .= " AND `Number` LIKE '" . $search . "%'";
			}
		} else {
			$sql = "SELECT `" . $description . "` as `Description` FROM `" . DB_PREFIX . "novaposhta_warehouses` WHERE `" . $city_description . "` = '" . $city . "'";
			
			if ($search) {
				$sql .= " AND `" . $description . "` LIKE '%" . $search . "%'";
			}
		}
		
		$shipping_methods = $this->config->get('novaposhta_shipping_methods');

		if (isset($shipping_methods['Warehouse']['warehouse_types'])) {
			foreach ($shipping_methods['Warehouse']['warehouse_types'] as $k => $v) {
				$shipping_methods['Warehouse']['warehouse_types'][$k] = "'" . $v . "'";
			}
			
			$sql .= " AND `TypeOfWarehouse` IN (" . implode(',', $shipping_methods['Warehouse']['warehouse_types']) . ")";
		}
		
		if (isset($this->session->data['shippingdata']['cart_weight'], $shipping_methods['Warehouse']['warehouses_filter_weight']) && $shipping_methods['Warehouse']['warehouses_filter_weight']) {
			$sql .= " AND (`TotalMaxWeightAllowed` >= '" . $this->session->data['shippingdata']['cart_weight'] . "' OR (`TotalMaxWeightAllowed` = 0 AND (`PlaceMaxWeightAllowed` >= '" . $this->session->data['shippingdata']['cart_weight'] . "' OR `PlaceMaxWeightAllowed` = 0)))";
		}
		
		$sql .= " ORDER BY `Number`+0";
				
		return $this->db->query($sql)->rows;	
	}
}