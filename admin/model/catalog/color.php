<?php
class ModelCatalogColor extends Model {	
    
    public function addColor($data) {
		$this->event->trigger('pre.admin.color.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");

		$color_set_id = $this->db->getLastId();

		if (isset($data['color'])) {
    		$sql = "SELECT * FROM " . DB_PREFIX . "color_set ORDER BY product_id ASC";
            
    		$query = $this->db->query($sql);

            $in_db_colors = array();
            
			foreach ($query->rows as $db_color) {
                $in_db_colors[] = $db_color['product_id'];
			}
          
            $is_saved_colors = array();
            /*
            foreach ($data['color'] as $language_id => $value) {
    			foreach ($value as $color) {
                    if ((!in_array($this->db->escape($color['product_id']), $in_db_colors)) && (!in_array($this->db->escape($color['product_id']), $is_saved_colors))) {
                        $is_saved_colors[] = $this->db->escape($color['product_id']);
                        
                        $this->db->query("INSERT INTO " . DB_PREFIX . "color_set SET color_set_id = '" . (int)$color_set_id . "', product_id = '" .  $this->db->escape($color['product_id']) . "', language_id = '" . (int)$language_id . "', color_name = '" .  $this->db->escape($color['color_name']) . "', color_image = '" .  $this->db->escape($color['color_image']) . "', sort_order = '" . (int)$color['sort_order'] . "'");
                    }
    			}
			}
            */
            
			foreach ($data['color'] as $color) {
                if ((!in_array($this->db->escape($color['product_id']), $in_db_colors)) && (!in_array($this->db->escape($color['product_id']), $is_saved_colors))) {
                    $is_saved_colors[] = $this->db->escape($color['product_id']);	
                    foreach ($color['color_name'] as $language_id => $value) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "color_set SET color_set_id = '" . (int)$color_set_id . "', product_id = '" .  $this->db->escape($color['product_id']) . "', language_id = '" . (int)$language_id . "', color_name = '" .  $this->db->escape($value) . "', color_image = '" .  $this->db->escape($color['color_image']) . "', sort_order = '" . (int)$color['sort_order'] . "'");
                    }
                }
			}
            
		}

		$this->event->trigger('post.admin.color.add', $color_set_id);

		return $color_set_id;
	}

	public function editColor($color_set_id, $data) {
		$this->event->trigger('pre.admin.color.edit', $data);

		$this->db->query("UPDATE " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE color_set_id = '" . (int)$color_set_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . (int)$color_set_id . "'");

		if (isset($data['color'])) {
    		$sql = "SELECT * FROM " . DB_PREFIX . "color_set ORDER BY product_id ASC";
            
    		$query = $this->db->query($sql);

            $in_db_colors = array();
            
			foreach ($query->rows as $db_color) {
                $in_db_colors[] = $db_color['product_id'];
			}
            
            $is_saved_colors = array();
            
            
			foreach ($data['color'] as $color) {
                if ((!in_array($this->db->escape($color['product_id']), $in_db_colors)) && (!in_array($this->db->escape($color['product_id']), $is_saved_colors))) {
                    $is_saved_colors[] = $this->db->escape($color['product_id']);	
                    foreach ($color['color_name'] as $language_id => $value) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "color_set SET color_set_id = '" . (int)$color_set_id . "', product_id = '" .  $this->db->escape($color['product_id']) . "', language_id = '" . (int)$language_id . "', color_name = '" .  $this->db->escape($value) . "', color_image = '" .  $this->db->escape($color['color_image']) . "', sort_order = '" . (int)$color['sort_order'] . "'");
                    }
                }
			}
		}

		$this->event->trigger('post.admin.color.edit', $color_set_id);
	}

	public function deleteColor($color_set_id) {
		$this->event->trigger('pre.admin.color.delete', $color_set_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "color WHERE color_set_id = '" . (int)$color_set_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . (int)$color_set_id . "'");

		$this->event->trigger('post.admin.color.delete', $color_set_id);
	}

	public function getColor($color_set_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "color WHERE color_set_id = '" . (int)$color_set_id . "'");

		return $query->row;
	}

	public function getColors($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "color";

		$sort_data = array(
			'name',
			'status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
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
	}

	public function getColorSetColors($color_set_id) {

		$color_data = array();
       
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . $color_set_id . "' ORDER BY sort_order ASC");

		foreach ($query->rows as $result) {
            $color_name_data = array();
            
            $color_data[$result['product_id']]['color_set_id'] = $result['color_set_id'];
            $color_data[$result['product_id']]['product_id'] = $result['product_id'];
            $color_data[$result['product_id']]['color_name'][$result['language_id']] = $result['color_name'];
            $color_data[$result['product_id']]['color_image'] = $result['color_image'];
            $color_data[$result['product_id']]['sort_order'] = $result['sort_order'];
		}


		return $color_data;
	}
    
	public function getTotalColors() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "color");

		return $query->row['total'];
	}
    
    
    
    
	/*public function addColor($data) {
		$this->event->trigger('pre.admin.color.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");

		$color_set_id = $this->db->getLastId();

		if (isset($data['color'])) {
    		$sql = "SELECT * FROM " . DB_PREFIX . "color_set ORDER BY product_id ASC";
            
    		$query = $this->db->query($sql);

            $in_db_colors = array();
            
			foreach ($query->rows as $db_color) {
                $in_db_colors[] = $db_color['product_id'];
			}
          
            $is_saved_colors = array();
            
			foreach ($data['color'] as $color) {
                if ((!in_array($this->db->escape($color['product_id']), $in_db_colors)) && (!in_array($this->db->escape($color['product_id']), $is_saved_colors))) {
                    $is_saved_colors[] = $this->db->escape($color['product_id']);	

                    $this->db->query("INSERT INTO " . DB_PREFIX . "color_set SET color_set_id = '" . (int)$color_set_id . "', product_id = '" .  $this->db->escape($color['product_id']) . "', color_name = '" .  $this->db->escape($color['color_name']) . "', color_image = '" .  $this->db->escape($color['color_image']) . "', sort_order = '" . (int)$color['sort_order'] . "'");
                }
			}
		}

		$this->event->trigger('post.admin.color.add', $color_set_id);

		return $color_set_id;
	}

	public function editColor($color_set_id, $data) {
		$this->event->trigger('pre.admin.color.edit', $data);

		$this->db->query("UPDATE " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE color_set_id = '" . (int)$color_set_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . (int)$color_set_id . "'");

		if (isset($data['color'])) {
    		$sql = "SELECT * FROM " . DB_PREFIX . "color_set ORDER BY product_id ASC";
            
    		$query = $this->db->query($sql);

            $in_db_colors = array();
            
			foreach ($query->rows as $db_color) {
                $in_db_colors[] = $db_color['product_id'];
			}
            
            $is_saved_colors = array();
            
			foreach ($data['color'] as $color) {
                if ((!in_array($this->db->escape($color['product_id']), $in_db_colors)) && (!in_array($this->db->escape($color['product_id']), $is_saved_colors))) {
                    $is_saved_colors[] = $this->db->escape($color['product_id']);	
				    $this->db->query("INSERT INTO " . DB_PREFIX . "color_set SET color_set_id = '" . (int)$color_set_id . "', product_id = '" .  $this->db->escape($color['product_id']) . "', color_name = '" .  $this->db->escape($color['color_name']) . "', color_image = '" .  $this->db->escape($color['color_image']) . "', sort_order = '" . (int)$color['sort_order'] . "'");
                }
            }
		}

		$this->event->trigger('post.admin.color.edit', $color_set_id);
	}

	public function deleteColor($color_set_id) {
		$this->event->trigger('pre.admin.color.delete', $color_set_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "color WHERE color_set_id = '" . (int)$color_set_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . (int)$color_set_id . "'");

		$this->event->trigger('post.admin.color.delete', $color_set_id);
	}

	public function getColor($color_set_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "color WHERE color_set_id = '" . (int)$color_set_id . "'");

		return $query->row;
	}

	public function getColors($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "color";

		$sort_data = array(
			'name',
			'status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
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
	}

	public function getColorSetColors($color_set_id) {
		$sql = "SELECT * FROM " . DB_PREFIX . "color_set WHERE color_set_id = '" . (int)$color_set_id . "' ORDER BY sort_order ASC";
        
		$query = $this->db->query($sql);

		return $query->rows;
	}
    
	public function getTotalColors() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "color");

		return $query->row['total'];
	}*/
}