<?php
	
function saveFilesFrom1C()
{
	global $output;
	$ftp_stream = ftp_connect(FTP_SERVER, FTP_PORT);
	$output .= '<br> получаем доступ к ftp - ';
	$output .= '<br>';
	if(ftp_login($ftp_stream, FTP_USER_NAME, FTP_USER_PASS) ){
		ftp_pasv($ftp_stream, true);
		$output .= 'Получили!';
	} else {
		$output .= 'Отказано!"';
	}
	saveFtpFile($ftp_stream, '/avail/', 'store_');
	saveFtpFile($ftp_stream, '/catalog/', 'catalog_');
	saveFtpFile($ftp_stream, '/prices/', 'price_');
	
	ftp_close($ftp_stream);
}
function saveFtpFile($ftp_stream, $dir_name, $replacement)
{
	global $output;
	$freshest_file = getFreshestFile($ftp_stream, $dir_name);
	
	$output .= '<br> преверяем свежесть файла - ' . $freshest_file . '<br>' ;

	$log_filename = TEMP_CSV . str_replace('/', '-', $dir_name);
	if(trim(file_get_contents($log_filename)) == $freshest_file)
	{
		return;
	}
	
	file_put_contents($log_filename, $freshest_file);
	
	$local_file = TEMP_CSV . str_replace($dir_name, $replacement, $freshest_file);
	$handle = fopen($local_file, 'w');
	ftp_fget($ftp_stream, $handle, $freshest_file, FTP_BINARY);
	fclose($handle);
	
	$output .= '<br> скачали - ' . $local_file . '<br>' ;
}

function getFreshestFile($ftp_stream, $dir)
{
	$files = ftp_nlist ( $ftp_stream, $dir);
	return max($files);
}	
	
function processProducts($products, $type, $start = 0)
{
	$limit = 50;
	$c_products = count($products);
	for ($i = 0; $i < $c_products; $i++){
		processProduct($products[$i], $type);
		if($i && $i % $limit == 0){
			$message = "index: " .  ($start + $i) .", index_all: " .  ($start + $i) . ", id1: " . $products[$i]['id1'];
			writeStatusProgress($message);
			writeLatId1($products[$i]['id1']);
		}
	}
	if($c_products < $limit ){
		$message = "index: " .  ($start + $i) .", index_all: " .  ($start + $i) . ", id1: " . $products[$i]['id1'];
		writeStatusProgress($message);
		writeLatId1($products[$i]['id1']);
	}
	
}


function processProduct($data, $type) {
	global $db;
	$data['model'] = $data['name'] . ' ' . $data['color'];
	$product_id = NULL;
	
	if(trim($data['model'])){
		$relevant_product_sql = "SELECT DISTINCT * FROM " . DB_PREFIX ."product"
			. " WHERE sku = '" . $db->escape($data['name']) . "' AND model ='" . $data['model'] . "'" ;
		$query = $db->query ($relevant_product_sql);
		if($query->num_rows){
			$product_id = (int)$query->row['product_id'];
		}
	}
	if(!$product_id && $type == 'catalog'){
		$product_id = createNewProduct($data);
		productToStore($product_id, $data);
		setProductDectiption($product_id, $data);
		update_url_alias ($product_id, $data['name'], 'product_id');
	} else {
	
		productDeleteOptions($product_id);
	}
	
	productAddOptions($product_id, $data);
	
	return $product_id;

}


function getProductOption($product_id, $option_value_id)
{
	global $db;
	$sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value"
		. " WHERE product_id = '" . $product_id . "' "
		. " AND option_value_id = '" . $option_value_id . "'";
	$query = $db->query($sql);
	if($query->num_rows){
		return (int)$query->row['product_option_value_id'];
	} else {
		return 0;
	}
}
function productAddOptions($product_id, $data)
{
	
	addColor($product_id, $data);
	addStandartColor($product_id, $data);
	
	$sizes = getProductSizes($data['id'], $data['color'], true);
	$data['quantity'] = addSizesGetQuantity($product_id, $sizes);
	$actual_size = array();
	foreach ($sizes as $size){
		if(!empty($size['price-2'])){
			$actual_size = $size;
			break;
		}
	}
	
	productDeleteDiscounts($product_id);
	if($actual_size){
		addProductDiscounts($product_id, $actual_size);

		$data['price'] = (float)$actual_size['price-2'];
	} else{
		$data['price'] = 0;
	}
	updateProduct($product_id, $data);
}
function productDeleteDiscounts($product_id) 
{
	global $db;
	$product_id = (int)$product_id;
	$db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . $product_id . "'");
	
}
function addProductDiscounts($product_id, $actual_size) 
{
	global $db;
	global $special_map;
	foreach ($special_map as $key => $special_map_item) {
		if($actual_size[$special_map_item['price_field']]){
			$sql = "INSERT INTO " . DB_PREFIX . "product_discount "
					. "SET product_id = '" . (int)$product_id . "', "
					. "customer_group_id = '" . (int)$special_map_item['customer_group_id'] . "', "
					. "quantity = '1', "
					. "priority = '" . (($key + 1) * 10)  . "', "
					. "price = '" . (float)$actual_size[$special_map_item['price_field']] . "' ";
			$db->query($sql);
		}
	}
	
}
function productDeleteOptions($product_id) 
{
	global $db;
	$db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
	$db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
}

function addSizesGetQuantity($product_id, $sizes)
{
	$product_option_values = array();
	$option_id = 74;
	$option_value_key = 'size';
	$quantity = 0;
	foreach ($sizes as $size_data) {
		$size_quantity = ((!empty($size_data['store']))? $size_data['store']: 0);
		$quantity = $quantity + $size_quantity;
		$product_option_values[] = array(
			'id' => $size_data['id'],
			'id1' => $size_data['id1'],
			'price' => 0,
			'quantity' => $size_quantity,
			'option_value_id' => getOptionValueId($option_id, $size_data[$option_value_key])
		);
	}
	addOption($product_id, $option_id, $product_option_values, 1);
	return $quantity;
}
function addColor($product_id, $data)
{
	$option_id = 87;
	$option_value_key = 'color';
	
	$product_option_values[] = array(
		'quantity' => ((!empty($data['store']))? $data['store']: 0),
		'option_value_id' => getOptionValueId($option_id, $data[$option_value_key])
	);
	addOption($product_id, $option_id, $product_option_values);
}

function addStandartColor($product_id, $data)
{
	$option_id = 13;
	$option_value_key = 'standart_color';
	
	$product_option_values[] = array(
		'quantity' => ((!empty($data['store']))? $data['store']: 0),
		'option_value_id' => getOptionValueId($option_id, $data[$option_value_key])
	);
	addOption($product_id, $option_id, $product_option_values);
}

function addOption($product_id, $option_id, $product_option_values, $required = 0)
{
	global $db;

	$db->query("INSERT INTO " . DB_PREFIX . "product_option SET "
		. "product_id = '" . (int)$product_id . "', "
		. "option_id = '" . $option_id . "', "
		. "required = '" . (int)$required . "'");

	$product_option_id = $db->getLastId();
	foreach ($product_option_values as $product_option_value) {
		addOptionValue($product_id, $option_id, $product_option_id, $product_option_value);
	}
}


function addOptionValue($product_id, $option_id, $product_option_id, $product_option_value)
{
	global $db;
	$db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET "
		. "product_option_id = '" . (int)$product_option_id . "', "
		. "product_id = '" . (int)$product_id . "', "
		. "option_id = '" . (int)$option_id . "', "
		. "option_value_id = '" . (int)$product_option_value['option_value_id'] . "', "
		. "quantity = '" . (int)$product_option_value['quantity'] . "', "
		. "subtract = '0', "
		. "price = '0', "
		. "price_prefix = '+', "
		. "points = '0', "
		. "points_prefix = '+', "
		. "weight = '0', "
		. ((!empty($product_option_value['id']))? "`id_1c`='" . (int)$product_option_value['id'] . "', ": "")
		. ((!empty($product_option_value['id1']))? "`id1_1c`='" . (int)$product_option_value['id1'] . "', ": "")
		. "weight_prefix = '+' "
		. "");
	
}
function getOptionValueId($option_id, $option_value_name)
{
	global $db;
	$sql = "SELECT option_value_id FROM " . DB_PREFIX . "option_value_description"
		. " WHERE `option_id`='$option_id' "
		. " AND `language_id`='" . LANGUAGE_ID . "' "
		. " AND LOWER(`name`) LIKE '" . mb_strtolower($option_value_name) . "'";
	$query = $db->query($sql);

	if($query->num_rows){
		$option_value_id = $query->row['option_value_id'];
	} else {
		$sql = "INSERT INTO " . DB_PREFIX . "option_value SET "
		. " `option_id`='$option_id', "
		. "`image`='', "
		. "`sort_order`='', "
		. "`option_value_1c_id`=''";
		$db->query($sql);
		$option_value_id = $db->getLastId();
		
		$sql = "INSERT INTO " . DB_PREFIX . "option_value_description SET "
		. " `option_value_id`='$option_value_id', "
		. " `option_id`='$option_id', "
		. "`language_id`='" . LANGUAGE_ID . "', "
		. "`name`='$option_value_name'";
		$db->query($sql);
	}
	return (int)$option_value_id; 
}
function updateProduct($product_id, $data)
{
	global $db;
	$need_comit = false;
	$sql = "UPDATE  " . DB_PREFIX . "product SET ";
	if(!empty($data['quantity'])){
		$sql .= "`quantity`='" . $data['quantity'] . "' ";
		$need_comit = true;
	}
	if(!empty($data['price'])){
		$sql .= ((!empty($data['quantity']))? ", " : '') . "`price`='" . (int)$data['price'] . "' ";
		$need_comit = true;
	}
	$sql .= "WHERE `product_id`='$product_id'";
	if($need_comit){
		$db->query($sql);
	}
	
}
function productToStore($product_id, $data)
{
	global $db;
	$db->query("INSERT INTO " . DB_PREFIX ."product_to_store SET store_id='0',  product_id='" . $product_id . "'");
}
function setProductDectiption($product_id, $data)
{
	global $db;
	$data['product_name'] = $data['type'] . ' ' . $data['model'];
		
	$sql = "INSERT INTO " . DB_PREFIX . "product_description SET ";
	$sql .= "product_id='" . $product_id ."', ";
	$sql .= "language_id='" . LANGUAGE_ID ."', ";
	$sql .= "name='" . $db->escape($data['product_name']) ."', ";
	$sql .= "meta_title='Купить " . $db->escape($data['product_name']) ."', ";
	$sql .= "description='', ";
	$sql .= "meta_description='" . $db->escape($data['name']) ."', ";
	$sql .= "meta_keyword='" . $db->escape($data['name']) ."', ";
	$sql .= "tag='" . $db->escape($data['name']) ."' ";
	$db->query($sql);
	return (int)$db->getLastId();
}
function createNewProduct($data)
{
	global $db;
	$sql = "INSERT INTO " . DB_PREFIX . "product SET ";
	$sql .= "`model`='" . $db->escape($data['model']) ."', ";
	$sql .= "`sku`='" . $db->escape($data['name']) ."', ";
	$sql .= "`upc`=' ', ";
	$sql .= "`ean`=' ', ";
	$sql .= "`jan`=' ', ";
	$sql .= "`isbn`=' ', ";
	$sql .= "`mpn`=' ', ";
	$sql .= "`quantity`='0', ";
	$sql .= "`stock_status_id`='" . STOCK_STATUS_ID ."', ";
	$sql .= "`manufacturer_id`='0', ";
	$sql .= "`shipping`='1', ";
	$sql .= "`price`='0', ";
	$sql .= "`points`='0', ";
	$sql .= "`tax_class_id`='9', ";
	$sql .= "`date_available`='". $db->escape(date('Y-m-d')) ."', ";
	$sql .= "`weight`='0', ";
	$sql .= "`weight_class_id`='1', ";
	$sql .= "`length`='0', ";
	$sql .= "`width`='0', ";
	$sql .= "`height`='0', ";
	$sql .= "`length_class_id`='1', ";
	$sql .= "`subtract`='1', ";
	$sql .= "`minimum`='1', ";
	$sql .= "`sort_order`='0', ";
	$sql .= "`status`='0', ";
	$sql .= "`viewed`='0', ";
	$sql .= "`location`='', ";
	$sql .= "`date_added`='". $db->escape(date('Y-m-d')) ."', ";
	$sql .= "`date_modified`='". $db->escape(date('Y-m-d')) ."' ";
	$db->query($sql);
	return (int)$db->getLastId();
}

function productToCategories ($product_id, $categories)
{
	global $db;
	$sql_del = "DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id='" . $product_id . "' ";
	$db->query($sql_del);
	$product_id = (int)$product_id;
	foreach (explode('#', $categories) as $key => $category_1c_id) {
		productToCategory($product_id, $category_1c_id, (($key)? 0: 1));
	}
	
}
function productToCategory ($product_id, $category_1c_id, $main = 0)
{
	$sql_ins .= "INSERT INTO " . DB_PREFIX . "product_to_category SET product_id='" . $product_id . "', ";
	$sql_ins .= "main='" . $main . "', ";
	$sql_ins .= "category_id = (SELECT DISTINCT category_id  FROM " . DB_PREFIX . "product_to_category WHERE category_1c_id='".$category_1c_id."') ";
}
function update_url_alias ($id, $Name, $query_part){
global $db;
		
		$ModelSeourlGenerate = new ModuleSeoUrlGenerator();
		$result = $ModelSeourlGenerate->seoUrlGenerateAjax($query_part,$Name,$only_to_latin = TRUE);
		$url_alias_query = $db->query ( "SELECT url_alias_id FROM " . DB_PREFIX . "url_alias where query='".$query_part."=".$id."'");
		if ($url_alias_query->num_rows) {
			$url_alias_id = (int)$url_alias_query->row['url_alias_id'];
			$update_url_alias = $db->query ( "UPDATE " . DB_PREFIX . "url_alias SET  keyword='".$result."' where url_alias_id='".(int)$url_alias_id."'");
		}else{
			$ins = new stdClass ();
			$ins->url_alias_id = NULL;
			$ins->query = $query_part."=".$id;
			$ins->keyword = $result;
			insertObject ( "" . DB_PREFIX ."url_alias", $ins ) ;
		}
}

function save_file_progress($str){
$handle = fopen(JPATH_BASE . DS .'TEMP'. DS . "progress_status.php", 'w+');
	if ($handle) {
		fwrite($handle, $str);
		fclose ($handle );
	}
}	


function parceCsv($filename, $type) 
{

	$handle = @fopen($filename, 'r+');
//	fgetcsv ($handle , 1000 , ";", '"' , "\\" ); // пропуск первой строки

	$unavaileble = array('0', 0, "'id", "id");
	while (($data = fgetcsv($handle , 1000 , ";", '"' , "\\" )) !== FALSE) {
	
		if(is_null($data[0]) ||in_array(html_entity_decode($data[0]), $unavaileble)) {
			continue;
		}
		switch($type){
			case 'catalog':
				saveCatalog($data);
				break;
			case 'price':
				savePrices($data);
				break;
			case 'store':
				saveStoreStatuses($data);
				break;
			default :
				die('Неизвестный тип!');
		}
		
	} 
	fclose($handle);
}
function saveStoreStatuses($data)
{
	global $db;

	$store = "`store`='" . (int)$data[2] . "' ";
	$sql = "INSERT IGNORE INTO ". DB_PREFIX ."exchange_store SET ";
	$sql .= "`id`='" . (int)$data[0] . "', ";
	$sql .= "`id1`='" . (int)$data[1] . "', ";
	$sql .= $store;
	$sql .= "ON DUPLICATE KEY UPDATE " . $store;
	$db->query($sql);
}
function savePrices($data)
{
	global $db;
	global $exchange_rate;

	$prices = "`price-1`='" . $exchange_rate * $data[2] . "', ";
	$prices .= "`price-2`='" . $exchange_rate * $data[3] . "', ";
	$prices .= "`price-3`='" . $exchange_rate * $data[4] . "', ";
	$prices .= "`price-4`='" . $exchange_rate * $data[5] . "', ";
	$prices .= "`price-5`='" . $exchange_rate * $data[6] . "' ";
	$sql = "INSERT IGNORE INTO ". DB_PREFIX ."exchange_price SET ";
	$sql .= "`id`='" . (int)$data[0] . "', ";
	$sql .= "`id1`='" . (int)$data[1] . "', ";
	$sql .= $prices;
	$sql .= "ON DUPLICATE KEY UPDATE " . $prices;
	
	
	$db->query($sql);
}
function saveCatalog($data)
{	
	global $db;
	$sql = "INSERT IGNORE INTO ". DB_PREFIX ."exchange_catalog SET ";
	$sql .= "`id`='" . (int)$data[0] . "', ";
	$sql .= "`article`='" . $db->escape($data[1]) . "', ";
	$sql .= "`id1`='" . (int)$data[2] . "', ";
	$sql .= "`name`='" . $db->escape($data[3]) . "', ";
	$sql .= "`size`='" . $db->escape(clearSize($data[4])) . "', ";
	$sql .= "`color`='" . $db->escape($data[5]) . "', ";
	$sql .= "`standart_color`='" . $db->escape($data[6]) . "', ";
	$sql .= "`od`='" . (int)$data[7] . "', ";
	$sql .= "`id_type`='" . (int)$data[8] . "', ";
	$sql .= "`type`='" . $db->escape($data[9]) . "' ";
	$db->query($sql);

	

}
function clearSize($size)
{
	$result = preg_replace('~[^0-9-\/]~', '', $size);
	return $result;
}
function getProductSizes($id = 0, $color ='', $price =false)
{
	global $db;
	$sql = "SELECT `ec`.*, es.store ";
	if($price){
		$sql .= ", `ep`.`price-1`, `ep`.`price-2`, `ep`.`price-3`, `ep`.`price-4`, `ep`.`price-5` ";
	}
	$sql .= "FROM " . DB_PREFIX . "exchange_store es ";
	$sql .= "LEFT JOIN " . DB_PREFIX . "exchange_catalog ec ON (es.id = ec.id AND es.id1 = ec.id1 ) ";

	if($price){
		$sql .= "LEFT JOIN " . DB_PREFIX . "exchange_price ep ON (ep.id = es.id AND ep.id1 = es.id1 ) ";
	}
	
	if($id && $color){
		$sql .= "WHERE es.id > 0 AND es.id='" . (int)$id . "' AND ec.color='" . $db->escape($color) . "'";
	}
	$query = $db->query($sql);
	return $query->rows;
}

function getDifferendProducts($id = 0, $start = false, $limit = false)
{
	global $db;
	$sql = "SELECT `ec`.*, es.store  ";
	$sql .= "FROM " . DB_PREFIX . "exchange_store es ";
	$sql .= "LEFT JOIN " . DB_PREFIX . "exchange_catalog ec ON (es.id = ec.id AND es.id1 = ec.id1 ) ";
	if($id){
		$sql .= "WHERE AND `es`.id='" . (int)$id . "' ";
	}
	$sql .= "GROUP BY `ec`.id, `ec`.color ";
	$sql .= "ORDER BY `ec`.id1 ";
	if($start !== false && $limit !== false){
		$sql .= "LIMIT " . (int)$start . ", " . (int)$limit . " ";
		
	}
	$query = $db->query($sql);
	return $query->rows;
}
function getChannel($link)
{
	$channel = curl_init();
	curl_setopt($channel, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($channel, CURLOPT_RETURNTRANSFER, false);
	curl_setopt($channel, CURLOPT_URL, $link);
	return $channel;
}
/*
useles
 *  */
function updateSizesGetQuantity($product_id, $sizes)
{
	global $db;
	$size_option_id = 74;
	
	$query = $db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . $product_id . "' AND option_id='" . $size_option_id .  "'");
	$registred_sizes = $query->rows;
//	var_dump($registred_sizes);die;
}

function productUpdateOptions($product_id, $data)
{
	updateColor($product_id, $data);
	updateStandartColor($product_id, $data);
	
	$sizes = getProductSizes($data['id'], $data['color'], true);
	$data['quantity'] = updateSizesGetQuantity($product_id, $sizes);
	$data['price'] = ((!empty($sizes[0]['price-2']))? (int)$sizes[0]['price-2']: 0);
	updateProduct($product_id, $data);
}
function updateStandartColor($product_id, $data)
{
	$option_id = 87;
	$option_value_key = 'standart_color';
	$option_value_id = getOptionValueId($option_id, $data[$option_value_key]);
	$product_option_value_id = getProductOption($product_id, $option_value_id);
	if(!$product_option_value_id){
		addStandartColor($product_id, $data);
	}
}
function updateColor($product_id, $data)
{
	$option_id = 13;
	$option_value_key = 'color';
	$option_value_id = getOptionValueId($option_id, $data[$option_value_key]);
	$product_option_value_id = getProductOption($product_id, $option_value_id);
	if(!$product_option_value_id){
		addColor($product_id, $data);
	}
}
