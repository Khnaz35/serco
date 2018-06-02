<?php
//******************************************************************
//****Модуль интеграции Opencart и 1С Управление торговлей 10.3/11**
//**********************Версия 1.1.2********************************
//*********************site-with-1c.ru******************************
//**********************Copyright 2017******************************
//******************************************************************


error_reporting  (E_ALL & ~E_NOTICE);
header('X-Accel-Buffering: no'); 
ini_set('output_buffering', 'Off'); 
ini_set('output_handler', ''); 
ini_set('zlib.output_handler',''); 
ini_set('zlib.output_compression', 'Off'); 
ignore_user_abort(true);
set_time_limit(0);

define( '_JEXEC', 1 );
define ( 'VM_ZIPSIZE', 1073741824 ); // Максимальный размер отправляемого архива в байтах (по умолчанию 1 гб) 
define ( 'VM_CODING', 'UTF-8' ); //Для использования другой кодировки в XML файлах используйте значение "UTF-8" или значение "Default" - кодировка по умолчанию
define ( 'UT_10_3', 1 ); //Модуль интеграции используется для 1С Управление торговлей ред. 10.3 (отличная обработка свойств номенклатуры, отключение удаления картинок при выгрузке только изменений)
define ( 'BUH_3', 0 ); //Модуль интеграции используется для 1С Бухгалтерия предприятия 3.х (дополнительные параметры выгрузки НДС по товару)
define ( 'VERSION_OC15', 0); // Используется версия Opencart 1.5: 1 - вкл , 0 - выкл
define ( 'VM_PASSWORD', 1); //Вкл или Выкл проверку пароля при авторизации 1С: 1 - вкл , 0 - выкл
define ( 'PARTS_EXCHANGE', 1); // Используется порционный обмен данными: 1 - вкл , 0 - выкл (Для УТ 10.3, УНФ 1.6)
//******************************************************************
//****************Настройки загрузки цен номенклатуры***************
define ( 'VM_PRICE_1C', 0 ); //Использовать цены по соглашению в 1С/или устанавливать цену для всех пользователей сайта по умолчанию: 1 - вкл цен по соглашению, 0 - выкл (используем "для всех")
define ( 'VM_TYPE_PRICE_1C', 'Розничный покупатель' );// Тип цен номенклатуры для отображение цены с видом "Default" в opencart, используется для 1С Розница с обновлением только цен и остатков, и при значение VM_PRICE_1C = 1
define ( 'VM_NDS', 'no' ); //Учитывать НДС в цене товара в заказе с сайта
//******************************************************************
//*******************Настройки загрузки реквизитов******************
define ( 'VM_SVOISTVA_1C', 1 ); //Использовать и отображать доп. реквизиты номенклатуры из 1С: 1 - вкл , 0 - выкл
define ( 'VM_MANUFACTURER_1C', 1 ); //Загрузка производителя номенклатуры будет загружаться через свойство "Производитель": 1 - вкл , 0 - выкл (производитель будет загружаться из реквизита "Производитель" указанный в карточке Номенклатуры )
define ( 'IMAGE_LOAD', 1 ); //Режим загрузки изображений товаров на сайт из 1С: 1 - вкл , 0 - выкл. По умолчанию загрузка картинок включена.
define ( 'VM_UPDATE_DESC_META', 1 ); //Обновлять описание и мета-информацию по товару после обмена с 1С: 1 - вкл. обновление, 0 - выкл
define ( 'VM_CURRENCY', 0 ); //Выгружать валюту для заказа с сайта: 1 - вкл , 0 - выкл
//******************************************************************
//***********Настройки обмена характеристик номенклатуры************
define ( 'VM_FEATURES_1C', 1 ); //Использовать характерстики номенклатуры 1С (справочник "Характеристики номенклатуры") на сайте: 1 - вкл , 0 - выкл
define ( 'VM_FEATURES_1C_PRICE', 0 ); //При значении "1" цены характеристик номенклатуры НЕ вычитаются из основной цены товара, подставляются в опции товара как есть из 1С. По умолчанию "0" - цены вычисляются.
define ( 'VM_PRICE_PARENT_FEATURES', 1 ); //Подставлять минимальную цену характерстики номенклатуры для родителя (основного) товара  1С: 1 - вкл , 0 - выкл. Если 0 - цена будет подставляться та, которая установлена в 1С
//******************************************************************


if(!defined('DS'))
{
   define('DS',DIRECTORY_SEPARATOR);
}

$directory = search_dir();
define ( 'JPATH_BASE', dirname ( __DIR__ ).DS.$directory ); //Путь к директории где установлен движок Opencart.

define ( 'TEMP_CSV', JPATH_BASE  . DS . 'temp-csv'. DS);
require_once ( JPATH_BASE .DS.'config.php' );
require_once ( JPATH_BASE .DS.'exchange'.DS.'database-csv.php');

$exchange_rate = 1; 
if( is_file(JPATH_BASE .DS.'exchange'.DS.'exchange_rate.php')){
	$tmp = file_get_contents(JPATH_BASE .DS.'exchange'.DS.'exchange_rate.php');
	$exchange_rate = (float)str_replace([',', ' '], ['.', ''], $tmp);
}

define ( 'FTP_SERVER', '144.76.43.176');
define ( 'FTP_PORT', 21);
define ( 'FTP_USER_NAME', 'sync-1c@sergio-cotti.ua');
define ( 'FTP_USER_PASS', '2N4ssCjkxxP8sehgzdVA');

// initialize the application Opencart
// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Database
if (VERSION_OC15 == 0){
	$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
}else{
	$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
}
set_error_handler('error_handler');
set_language_id();




function error_handler($code, $msg, $file, $line) {
	write_log("Произошла ошибка $msg ($code)\n $file ($line)");
	if (($code == E_ERROR) or ($code == E_WARNING) or ($code == E_USER_ERROR) or ($code == E_USER_NOTICE)){
		save_file_progress('stop');
	}	
	return;
}



function set_language_id() {
global $db;
	
	$language_query = $db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE status = '1' ORDER BY language_id DESC LIMIT 1");
    if ($language_query->num_rows) {
		$language_id = (int)$language_query->row['language_id'];
		define ( 'LANGUAGE_ID', $language_id );
	}else{
		define ( 'LANGUAGE_ID', 1 );//Идентификатор языка сайта, по умолчанию 1 (Русский)
	}
	unset($language_query);
} 

$domain = $_SERVER['HTTP_HOST'];

$stock_status_id_query = $db->query ( "SELECT stock_status_id FROM " . DB_PREFIX ."stock_status WHERE name = 'Нет в наличии'" );
$stock_status_id = (int)$stock_status_id_query->row['stock_status_id'];

define('STOCK_STATUS_ID', $stock_status_id);

// customer_group_name - для наглядности
$special_map = array(
	array('customer_group_name' => 'Мелкооптовый покупатель', 'customer_group_id' => 2, 'price_field' => 'price-3'),
	array('customer_group_name' => 'Оптовый покупатель', 'customer_group_id' => 3, 'price_field' => 'price-1'),
	array('customer_group_name' => 'Дропшиппер', 'customer_group_id' => 4, 'price_field' => 'price-4'),
	
);