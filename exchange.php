<?php
$start_time = microtime(true);
$output = '';
if(!defined('DS'))
{
   define('DS',DIRECTORY_SEPARATOR);
}	
$directory = search_dir();
define ( 'JPATH_BASE', dirname ( __DIR__ ).DS.$directory );

function search_dir() {
	$dir_file = dirname(__FILE__);
	$dir_dir = dirname ( __DIR__ );
	$directory_public_html_1 = str_replace($dir_dir,"",$dir_file);
	$directory_public_html_2 = str_replace("/","",$directory_public_html_1);
	$directory_public_html_cc = stripcslashes($directory_public_html_2);
	return $directory_public_html_cc;
} 
require_once ( JPATH_BASE .DS.'exchange'.DS.'init.php');
require_once ( JPATH_BASE .DS.'exchange'.DS.'funk.php');
require_once ( JPATH_BASE .DS.'exchange'.DS.'tests.php');

if($_REQUEST ['test'] == '1'){
	$_REQUEST ['mode'] = '';

}


//*******************Этапы подключения 1с и opencart*******************
header('charset = utf8');

$allowed_types = array(
	'catalog',
	'price',
	'store',
);
/**
 * Заливка каталога частями
 */
if (isset ( $_REQUEST ['mode'] ) && $_REQUEST ['mode'] == 'process'){
	
	$output .= '<br> Проверяем свежесть файлов на фтп <br>';
	saveFilesFrom1C();
	
	'http://1177668.rz289033.web.hosting-test.net/exchange.php?mode=process';
	$has_files = false;
	$unallowed_filenames = array(
		'.',
		'..',
	);
	foreach (scandir(TEMP_CSV) as $value) {
		if(!in_array($value, $unallowed_filenames)){
			$type = false;
			$tmp_type = preg_replace('~_.+~', '', $value);
			switch ($tmp_type){
				case 'catalog': 
					$type = 'catalog';
					break;
				case 'price': 
				case 'prise': 
					$type = 'price';
					break;
				case 'store': 
					$type = 'store';
					break;
					
			}
			
			if($type && is_file(TEMP_CSV .  $value)){
				$has_files = true;
				$output .= '<br> Обрабатываем файл: ' . $value . '<br>';
				parceCsv(TEMP_CSV .  $value, $type);
				$output .= '<br> Удаляем файл: ' . $value . '<br>';
				unlink(TEMP_CSV .  $value);
			}
			
			
		}
		
	}

	if($has_files){
		$start = ((!empty($_REQUEST['start']))? (int)$_REQUEST['start']: 0);
		$limit = ((!empty($_REQUEST['limit']))? (int)$_REQUEST['limit']: 5);
		$max = ((!empty($_REQUEST['max']))? (int)$_REQUEST['max']: 25);
		
		$output .= '<br> Применяем изменения <br>';
		if($start){
			processProducts(getDifferendProducts(0, $start, $limit), 'catalog', $start);
		} else {
			writeStatusProgress('start', 0);
			processProducts(getDifferendProducts(), 'catalog');
		}
		
	}
	
}

echo $output, microtime(true) - $start_time;