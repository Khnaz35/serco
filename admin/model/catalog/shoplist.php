<?php
class ModelCatalogShoplist extends Model {
	public function addShoplist($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "'");

		$shoplist_id = $this->db->getLastId();

		foreach ($data['shoplist_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_description SET shoplist_id = '" . (int)$shoplist_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', address = '" . $this->db->escape($value['address']) . "', phone = '" . $this->db->escape($value['phone']) . "', email = '" . $this->db->escape($value['email']) . "', workingtime = '" . $this->db->escape($value['workingtime']) . "', googlemap = '" . $this->db->escape($value['googlemap']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		if (isset($data['shoplist_store'])) {
			foreach ($data['shoplist_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_to_store SET shoplist_id = '" . (int)$shoplist_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['shoplist_layout'])) {
			foreach ($data['shoplist_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_to_layout SET shoplist_id = '" . (int)$shoplist_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		$this->cache->delete('shoplist');

		return $shoplist_id;
	}

	public function editShoplist($shoplist_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "shoplist SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "' WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_description WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		foreach ($data['shoplist_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_description SET shoplist_id = '" . (int)$shoplist_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', address = '" . $this->db->escape($value['address']) . "', phone = '" . $this->db->escape($value['phone']) . "', email = '" . $this->db->escape($value['email']) . "', workingtime = '" . $this->db->escape($value['workingtime']) . "', googlemap = '" . $this->db->escape($value['googlemap']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_to_store WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		if (isset($data['shoplist_store'])) {
			foreach ($data['shoplist_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_to_store SET shoplist_id = '" . (int)$shoplist_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_to_layout WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		if (isset($data['shoplist_layout'])) {
			foreach ($data['shoplist_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "shoplist_to_layout SET shoplist_id = '" . (int)$shoplist_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		$this->cache->delete('shoplist');
	}

	public function deleteShoplist($shoplist_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist WHERE shoplist_id = '" . (int)$shoplist_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_description WHERE shoplist_id = '" . (int)$shoplist_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_to_store WHERE shoplist_id = '" . (int)$shoplist_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "shoplist_to_layout WHERE shoplist_id = '" . (int)$shoplist_id . "'");
        
		$this->cache->delete('shoplist');
	}

	public function getShoplist($shoplist_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'shoplist_id=" . (int)$shoplist_id . "' LIMIT 1) AS keyword FROM " . DB_PREFIX . "shoplist WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		return $query->row;
	}

	public function getShoplists($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "shoplist i LEFT JOIN " . DB_PREFIX . "shoplist_description id ON (i.shoplist_id = id.shoplist_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			$sort_data = array(
				'id.title',
				'i.sort_order'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY id.title";
			}

			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}

			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}

				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}

			$query = $this->db->query($sql);

			return $query->rows;
		} else {
			$shoplist_data = $this->cache->get('shoplist.' . (int)$this->config->get('config_language_id'));

			if (!$shoplist_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shoplist i LEFT JOIN " . DB_PREFIX . "shoplist_description id ON (i.shoplist_id = id.shoplist_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$shoplist_data = $query->rows;

				$this->cache->set('shoplist.' . (int)$this->config->get('config_language_id'), $shoplist_data);
			}

			return $shoplist_data;
		}
	}

	public function getShoplistDescriptions($shoplist_id) {
		$shoplist_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shoplist_description WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		foreach ($query->rows as $result) {
			$shoplist_description_data[$result['language_id']] = array(
				'title'             => $result['title'],
				'description'       => $result['description'],
				'address'           => $result['address'],
				'phone'             => $result['phone'],
				'email'             => $result['email'],
				'workingtime'       => $result['workingtime'],
				'googlemap'         => $result['googlemap']
			);
		}

		return $shoplist_description_data;
	}

	public function getShoplistStores($shoplist_id) {
		$shoplist_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shoplist_to_store WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		foreach ($query->rows as $result) {
			$shoplist_store_data[] = $result['store_id'];
		}

		return $shoplist_store_data;
	}

	public function getShoplistLayouts($shoplist_id) {
		$shoplist_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "shoplist_to_layout WHERE shoplist_id = '" . (int)$shoplist_id . "'");

		foreach ($query->rows as $result) {
			$shoplist_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $shoplist_layout_data;
	}

	public function getTotalShoplists() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "shoplist");

		return $query->row['total'];
	}

	public function getTotalShoplistsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "shoplist_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}