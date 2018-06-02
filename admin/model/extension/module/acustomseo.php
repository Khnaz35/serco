<?php
class ModelExtensionModuleAcustomseo extends Model {

  public function getAllSeoUrls($data){

    if ($this->request->server['HTTPS']) {
      $base_url = HTTPS_CATALOG;
    } else {
      $base_url = HTTP_CATALOG;
    }

    $sql = "SELECT * FROM `".DB_PREFIX."url_alias` ";

    $sort_data = array(
      'query',
      'keyword',
    );

    if (isset($data['keyword']) && $data['keyword']) {
      $sql .= " WHERE `keyword` LIKE '%" . $data['keyword'] ."%'";
    } 

    if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
      $sql .= " ORDER BY " . $data['sort'];
    } else {
      $sql .= " ORDER BY query";
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
    $rows = $query->rows;
    
    $urls = array();
    foreach ($rows as $key => $row) {
      $query = $row['query'];
      $query = explode('=', $query);
      if($query[0] == 'category_id'){
        $url_query = $base_url.'index.php?route=product/category&path='.$query[1];
      }elseif($query[0] == 'product_id'){
        $url_query = $base_url.'index.php?route=product/product&product_id='.$query[1];
      }elseif($query[0] == 'manufacturer_id'){
        $url_query = $base_url.'index.php?route=product/manufacturer/info&manufacturer_id='.$query[1];
      }elseif($query[0] == 'information_id'){
        $url_query = $base_url.'index.php?route=information/information&information_id='.$query[1];
      }else{
        $url_query = $base_url.'index.php?route='.$row['query'];
      }
      $url_seo = $base_url.$row['keyword'];
      $urls[] = array(
        'url_alias_id' => $row['url_alias_id'],
        'query'        => $url_query,
        'keyword'      => $url_seo,
        'edit'         => $this->url->link('extension/module/acustomseo/edit', 'token=' . $this->session->data['token'].'&url_alias_id='.$row['url_alias_id'], true),
        'delete'       => $this->url->link('extension/module/acustomseo/delete', 'token=' . $this->session->data['token'].'&url_alias_id='.$row['url_alias_id'], true)
      );
    }
    return $urls;
  }

  public function getTotalSeoUrls($data){

    $sql = "SELECT count(*) as total FROM `".DB_PREFIX."url_alias` ";   

    if (isset($data['keyword']) && $data['keyword']) {
      $sql .= " WHERE `keyword` LIKE '%" . $data['keyword'] ."%'";
    }  

    $query = $this->db->query($sql);
    $row = $query->row;    
    
    return isset($row['total']) ? $row['total'] : 0;
  }

  public function addkeyword(){
    if ($this->request->server['HTTPS']) {
      $base_url = HTTPS_CATALOG;
    } else {
      $base_url = HTTP_CATALOG;
    }

    $url = $this->request->post['url'];
    $keyword = $this->request->post['keyword'];
    $keyword = str_replace($base_url, '', $keyword);
    $keyword = str_replace(' ', '-', $keyword);

    $url = explode('?', $url);
    $url = isset($url[1]) ? $url[1] : '';
    
    $query = '';
    if($url){
      $url = explode('&', $url);
      foreach ($url as $key => $url_v) {
        $url_v = str_replace('amp;', '', $url_v);        
        $url_v = explode('=', $url_v);

        if($url_v[0] == 'product_id'){
          $query = 'product_id='.$url_v[1];
        }elseif($url_v[0] == 'path'){
          $path = $url_v[1];          
          $parts = explode('_', (string)$path);
          $category_id = (int)array_pop($parts);
          $query = 'category_id='.$category_id;
        }elseif($url_v[0] == 'manufacturer_id'){
          $query = 'manufacturer_id='.$url_v[1];
        }elseif($url_v[0] == 'information_id'){
          $query = 'information_id='.$url_v[1];
        }elseif($url_v[0] == 'route'){
          $query = $url_v[1];
        }
      }
    }

    if(empty($query)) return;

    $sql = "INSERT INTO `".DB_PREFIX."url_alias` SET `query` = '$query', `keyword` = '$keyword'";
    $this->db->query($sql);
  }

  public function editkeyword($url_alias_id){
    if ($this->request->server['HTTPS']) {
      $base_url = HTTPS_CATALOG;
    } else {
      $base_url = HTTP_CATALOG;
    }

    $url = $this->request->post['url'];
    $keyword = $this->request->post['keyword'];
    $keyword = str_replace($base_url, '', $keyword);
    $keyword = str_replace(' ', '-', $keyword);

    $url = explode('?', $url);
    $url = isset($url[1]) ? $url[1] : '';
    
    $query = '';
    if($url){
      $url = explode('&', $url);
      foreach ($url as $key => $url_v) {
        $url_v = str_replace('amp;', '', $url_v);        
        $url_v = explode('=', $url_v);

        if($url_v[0] == 'product_id'){
          $query = 'product_id='.$url_v[1];
        }elseif($url_v[0] == 'path'){
          $path = $url_v[1];          
          $parts = explode('_', (string)$path);
          $category_id = (int)array_pop($parts);
          $query = 'category_id='.$category_id;
        }elseif($url_v[0] == 'manufacturer_id'){
          $query = 'manufacturer_id='.$url_v[1];
        }elseif($url_v[0] == 'information_id'){
          $query = 'information_id='.$url_v[1];
        }elseif($url_v[0] == 'route'){
          $query = $url_v[1];
        }
      }
    }

    if(empty($query)) return;

    $sql = "UPDATE `".DB_PREFIX."url_alias` SET `query` = '$query', `keyword` = '$keyword' WHERE `url_alias_id` = '".(int)$url_alias_id."'";
    $this->db->query($sql);
  }

  public function deleteKeyword($url_alias_id = ''){
    if(is_array($url_alias_id)){
      foreach ($url_alias_id as $key => $url_alias_id_) {
        $sql = "DELETE FROM `".DB_PREFIX."url_alias` WHERE `url_alias_id` = '".(int)$url_alias_id_."'";
        $this->db->query($sql);
      }      
    }elseif($url_alias_id){
      $sql = "DELETE FROM `".DB_PREFIX."url_alias` WHERE `url_alias_id` = '".(int)$url_alias_id."'";
      $this->db->query($sql);
    }
  }
	
  public function getUrlAlias($keyword = '', $url_alias_id = '') {
    if ($this->request->server['HTTPS']) {
      $base_url = HTTPS_CATALOG;
    } else {
      $base_url = HTTP_CATALOG;
    }

    $keyword = $keyword;
    $keyword = str_replace($base_url, '', $keyword);
    $keyword = str_replace(' ', '-', $keyword);

    $sql = "SELECT * FROM " . DB_PREFIX . "url_alias WHERE ";

    if($keyword)
    $sql .= "keyword = '" . $this->db->escape($keyword) . "'";

    if($url_alias_id){
      $sql .= ($keyword) ? ' and ' : '';
      $sql .= "url_alias_id = '" .(int) $url_alias_id . "'";
    }

    $query = $this->db->query($sql);

    return $query->row;
  }
}
?>