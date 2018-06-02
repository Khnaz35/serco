<?php
class ModelCatalogShoplist extends Model {

	public function getShoplists() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shoplist i LEFT JOIN " . DB_PREFIX . "shoplist_description id ON (i.shoplist_id = id.shoplist_id) LEFT JOIN " . DB_PREFIX . "shoplist_to_store i2s ON (i.shoplist_id = i2s.shoplist_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");

		return $query->rows;
	}

}