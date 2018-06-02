<?php
$filename = dirname(__FILE__) . '/cron-log-322223.txt';
if($_GET['clear']){
	file_put_contents($filename, '');
	die();
}	
$log = PHP_EOL . '********************************';	
$log .= PHP_EOL . date("H:i:s d-m-Y");	
$log .= PHP_EOL .print_r($_GET, true);
file_put_contents($filename, $log, FILE_APPEND);
