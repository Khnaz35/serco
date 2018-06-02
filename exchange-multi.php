<?php
	die;
$start_time = microtime(true);
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


//*******************Этапы подключения 1с и opencart*******************

header('charset = utf8');



$allowed_types = array(
	'catalog',
	'price',
	'store',
);

if (isset ( $_REQUEST ['type'] ) && in_array($_REQUEST ['type'], $allowed_types) && isset ( $_REQUEST ['mode'] ) && $_REQUEST ['mode'] == 'import' && is_file(TEMP_CSV . $_REQUEST['filename']))
{	
	//http://sergio/exchange.php?type=catalog&mode=import&filename=catalog_2018-03-19_06-27-42.csv
	//http://sergio/exchange.php?type=price&mode=import&filename=prise_2018-03-11_23-20-57.csv
	//http://sergio/exchange.php?type=store&mode=import&filename=store_2018-03-19_06-40-40.csv
	parceCsv(TEMP_CSV .  $_REQUEST['filename'], $_REQUEST ['type']);
}

/**
 * Заливка каталога частями
 */
if (isset ( $_REQUEST ['type'] ) && $_REQUEST ['type'] == 'test' 
	&& isset ( $_REQUEST ['mode'] ) && $_REQUEST ['mode'] == 'process'
	&& isset ( $_REQUEST ['start'] )
	&& isset ( $_REQUEST ['limit'] )
	
	){
	writeStatusProgress((int)$_REQUEST['start'] . ' ' .  (int)$_REQUEST['limit']);
}
if (isset ( $_REQUEST ['type'] ) && $_REQUEST ['type'] == 'test' && isset ( $_REQUEST ['mode'] ) && $_REQUEST ['mode'] == 'multi-curl'){
	multiCurlPartialProcess(((!empty($_REQUEST ['limit']))? $_REQUEST ['limit']: 50));
}
if (isset ( $_REQUEST ['type'] ) && in_array($_REQUEST ['type'], $allowed_types) && isset ( $_REQUEST ['mode'] ) && $_REQUEST ['mode'] == 'process'){
	
	'http://1177668.rz289033.web.hosting-test.net/exchange.php?type=catalog&mode=process&start=0&limit=50&max=1000';

	$start = ((!empty($_REQUEST['start']))? (int)$_REQUEST['start']: 0);
	$limit = ((!empty($_REQUEST['limit']))? (int)$_REQUEST['limit']: 5);
	$max = ((!empty($_REQUEST['max']))? (int)$_REQUEST['max']: 25);
	
	if($start){
		processProducts(getDifferendProducts(0, $start, $limit), 'catalog', $start);
	} else {
		writeStatusProgress('start', 0);
		processProducts(getDifferendProducts(0, $start, $limit), 'catalog');
	}
	usleep(5000000);
	curlPartialProcess($start, $limit, $max);
	
}


function multiCurlPartialProcess($limit = 50)
{
	writeStatusProgress('start-multi', 0);
	
	$channels = array();
	$running = null;
	$mh = curl_multi_init();
	$products = getDifferendProducts();
	$end = count($products)/50;
	
	$url = $_SERVER['HTTP_HOST']. '/exchange.php?type=test&mode=process';
	for ($i = 0; $i < $end ; $i++) {
		$start = $i*$limit;
		$link .= $url . '&start=' . $start . '&limit=' . $limit;
		$channel = getChannel($link);
		curl_multi_add_handle($mh, $channel);
		$channels[] = $channel;
	}
	
	curl_multi_exec($mh, $running);
	
//	foreach ($channels as $channel) {
//		curl_multi_remove_handle($mh, $channel);
//	}
	
	sleep(20);
	
	curl_multi_close($mh);

}	



function _curlPartialProcess($start, $limit, $max)
{
	die;
	if($start >=0 && $start < $max){
		writeStatusProgress($start . ' ' .  $limit . ' ' . $max);
		$url = $_SERVER['HTTP_HOST']. '/exchange.php?type=catalog&mode=process&start=' . ($start + $limit) . '&limit=' . $limit . '&max=' .$max;
		$ch = curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);
		$data = curl_exec($ch);
//		$info =  curl_getinfo($ch,CURLINFO_HTTP_CODE); 
		curl_close($ch); 
		var_dump($data);die;
	} 
}


echo microtime(true) - $start_time;


