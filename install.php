<?php
//******************************************************************
//**Модуль интеграции Opencart и 1С Управление торговлей 10.3/11****
//**********************Версия 1.1.1********************************
//*********************site-with-1c.ru******************************
//**********************Copyright 2017******************************
//*********************Установочный файл****************************
//******************************************************************
//******************************************************************
$ver = (float)phpversion();

if ($ver < 5.3) {
	
	header("Content-Type: text/html; charset=utf-8");
    echo 'Для продолжения установки, необходимо обновить версию PHP на хостинге до 5.3 или выше.';
	exit();
}

define( '_JEXEC', 1 );
define ( 'VM_ZIP', 'no' ); 		// Использование zip архивов (использование zip-архивов не поддерживается)
define ( 'VM_ZIPSIZE', 52428800 ); 	// Максимальный размер архива в байтах (по умолчанию 50 мб) 
define ( 'VM_CODING', 'UTF-8' ); //Для использования другой кодировки в XML файлах используйте значение "UTF-8" или значение "Default" - кодировка по умолчанию
define ('VERSION_OC15', '0'); // Используется версия Opencart 1.5
//******************************************************************
//******************************************************************
if(!defined('DS'))
{
   define('DS',DIRECTORY_SEPARATOR);
}

//define('JPATH_BASE', '__DIR__' );
$directory = search_dir();
define ( 'JPATH_BASE', dirname ( __DIR__ ).DS.$directory ); //Путь к директории где установлен движок Opencart.


require_once ( JPATH_BASE .DS.'config.php' );
//require_once ( JPATH_BASE .DS.'libraries'.DS.'joomla'.DS.'factory.php' );
require_once ( JPATH_BASE .DS.'database.php');

//define ( 'RELATIVE_PATH',  DS . 'images' . DS . 'stories' . DS . 'virtuemart' . DS . 'product' );
# директория в которую записываются картинки 
//define ( 'JPATH_BASE_PICTURE', dirname ( __DIR__ ) . RELATIVE_PATH );


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
$registry->set('db', $db);


//Функции
function search_dir() {
$dir_file = dirname(__FILE__);
$dir_dir = dirname ( __DIR__ );
$directory_public_html_1 = str_replace($dir_dir,"",$dir_file);
$directory_public_html_2 = str_replace("/","",$directory_public_html_1);
$directory_public_html_cc = stripcslashes($directory_public_html_2);
return $directory_public_html_cc;
} 
echo "Success connecting...<br />";

UpdateDB();
function UpdateDB() {
	
global $db;
//$jconfig = new JConfig();
$prefixtable = DB_PREFIX;//определяем префикс таблиц
$database_name = DB_DATABASE; //определяем наименование базы данных 

//создание колонки 	category_1c_id в таблице virtuemart_categories_ru_ru
$column_name_query = $db->query ("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name =  '".$prefixtable."category' AND table_schema =  '".$database_name."' AND COLUMN_NAME = 'category_1c_id'"); 

		if ($column_name_query->num_rows) 
		{
			echo "Column category_1c_id already exists. Not create.<br />";
			
		}
		else
		{ 
			//создаем новую колонку
			$database = DB_DATABASE;
			$host = DB_HOSTNAME;
			$user = DB_USERNAME;
			$password = DB_PASSWORD;
			$mysqli = new mysqli("".$host."", "".$user."", "".$password."", "".$database."");
			$mysqli->query("ALTER TABLE ".$prefixtable."category ADD category_1c_id TEXT NOT NULL");
			echo "Create column category_1c_id... Success. <br />";
			mysqli_close($mysqli);
		}

//создание колонки 	product_1c_id в таблице virtuemart_products_ru_ru
$column_name_query = $db->query ("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name =  '".$prefixtable."product' AND table_schema =  '".$database_name."' AND COLUMN_NAME = 'product_1c_id' ");

		if ($column_name_query->num_rows)  
		{
			echo "Column product_1c_id already exists. Not create.<br />";
		}
		else
		{ 
			//создаем новую колонку
			$database2 = DB_DATABASE;
			$host2 = DB_HOSTNAME;
			$user2 = DB_USERNAME;
			$password2 = DB_PASSWORD;
			$mysqli2 = new mysqli("".$host2."", "".$user2."", "".$password2."", "".$database2."");
			$mysqli2->query("ALTER TABLE ".$prefixtable."product ADD product_1c_id TEXT NOT NULL");
			echo "Create column product_1c_id... Success. <br />";
			mysqli_close($mysqli2);
		}
//создание колонки 	attribute_1c_id в таблице attribute
$column_name_query = $db->query ("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name =  '".$prefixtable."attribute' AND table_schema =  '".$database_name."' AND COLUMN_NAME = 'attribute_1c_id' ");

		if ($column_name_query->num_rows)  
		{
			echo "Column attribute_1c_id already exists. Not create.<br />";
		}
		else
		{ 
			//создаем новую колонку
			$database2 = DB_DATABASE;
			$host2 = DB_HOSTNAME;
			$user2 = DB_USERNAME;
			$password2 = DB_PASSWORD;
			$mysqli2 = new mysqli("".$host2."", "".$user2."", "".$password2."", "".$database2."");
			$mysqli2->query("ALTER TABLE ".$prefixtable."attribute ADD attribute_1c_id TEXT NOT NULL");
			echo "Create column attribute_1c_id... Success. <br />";
			mysqli_close($mysqli2);
		}	

//создание колонки 	customer_group_1c_id в таблице customer_group_description
$column_name_query = $db->query ("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name =  '".$prefixtable."customer_group_description' AND table_schema =  '".$database_name."' AND COLUMN_NAME = 'customer_group_1c_id' ");

		if ($column_name_query->num_rows) 
		{
			echo "Column customer_group_1c_id already exists. Not create.<br />";				
		}
		else
		{ 
			//создаем новую колонку
			$database3 = DB_DATABASE;
			$host3 = DB_HOSTNAME;
			$user3 = DB_USERNAME;
			$password3 = DB_PASSWORD;
			$mysqli3 = new mysqli("".$host3."", "".$user3."", "".$password3."", "".$database3."");
			$mysqli3->query("ALTER TABLE ".$prefixtable."customer_group_description ADD customer_group_1c_id TEXT NOT NULL");
			echo "Create column customer_group_1c_id... Success. <br />";
			mysqli_close($mysqli3);
		}

//характеристики номенклатуры		
//создание колонки 	option_value_1c_id в таблице option_value
$column_name_query = $db->query ("SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name =  '".$prefixtable."option_value' AND table_schema =  '".$database_name."' AND COLUMN_NAME = 'option_value_1c_id' ");

		if ($column_name_query->num_rows) 
		{
			echo "Column option_value_1c_id already exists. Not create.<br />";				
		}
		else
		{ 
			//создаем новую колонку
			$database3 = DB_DATABASE;
			$host3 = DB_HOSTNAME;
			$user3 = DB_USERNAME;
			$password3 = DB_PASSWORD;
			$mysqli3 = new mysqli("".$host3."", "".$user3."", "".$password3."", "".$database3."");
			$mysqli3->query("ALTER TABLE ".$prefixtable."option_value ADD option_value_1c_id TEXT NOT NULL");
			echo "Create column option_value_1c_id... Success. <br />";
			mysqli_close($mysqli3);
		}


		
}




?>