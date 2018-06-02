<?php
$host = $_SERVER['HTTP_HOST'];
define('HTTP_SERVER', "http://$host/");

// HTTPS
define('HTTPS_SERVER', "http://$host/");

// DIR
$dir = dirname(__FILE__);

define('DIR_APPLICATION', $dir . '/catalog/');
define('DIR_IMAGE', $dir . '/image/');
define('DIR_SYSTEM', $dir . '/system/');
define('DIR_MLOG', $dir . '/log/');
define('DIR_LANGUAGE', DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE', DIR_APPLICATION . 'view/theme/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');
define('DIR_CACHE', DIR_SYSTEM . '/storage/cache/');
define('DIR_DOWNLOAD', DIR_SYSTEM . 'storage/download/');
define('DIR_LOGS', DIR_SYSTEM . 'storage/logs/');
define('DIR_MODIFICATION', DIR_SYSTEM . 'storage/modification/');
define('DIR_UPLOAD', DIR_SYSTEM . 'storage/upload/');

// SINGLE currency
define('SINGLE_CURRENCY', 'UAH');

// DB
define('DB_DRIVER', 'mysqli');

//define('DB_HOSTNAME', 'localhost');
//define('DB_USERNAME', 'marketer94_ocpro');
//define('DB_PASSWORD', 'LVYceX1bnc1w');
//define('DB_DATABASE', 'marketer94_ocpro');
define('DB_HOSTNAME', 'rz289033.mysql.tools');
define('DB_USERNAME', 'rz289033_dev');
define('DB_PASSWORD', 'tr2vjmzl');
define('DB_DATABASE', 'rz289033_dev');
define('DB_PORT', '3306');
define('DB_PREFIX', 'ser_oc_gio_');
