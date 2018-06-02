<?php

define('WU_PATH_ROOT', dirname(__FILE__).'/');
define('WU_PATH_LOG', WU_PATH_ROOT.'var/log/');
define('WU_PATH_LOCK', WU_PATH_ROOT.'var/lock/');
define('WU_PATH_TMP', WU_PATH_ROOT.'var/tmp/');
define('WU_PATH_CONN', WU_PATH_ROOT.'connectors/');

require_once WU_PATH_ROOT.'config.php';
require_once WU_PATH_LIB.'Error.php';
require_once WU_PATH_CMF.'wuGraph.php';

define('WU_PATH_SYNC', WU_PATH_VAR.'sync/');
define('PATH_LOCK', WU_PATH_SYNC);

$lockfile = 'sync_orders';
$lock = false;
if ( !$a = AcquireLock($lock, $lockfile) ) die('Sync script is busy');

// Initialize errors handling class
$oErr = new Error(WU_ERROR_MODE, WU_PATH_LOG, WU_ERROR_SUPPORT);
if ( defined('WU_ERROR_EMAIL') ) $oErr->SetEmail(WU_ERROR_EMAIL);

// Debug function
function D($var, $exit = 0)
{
    print '<div style="background-color: #ffffff; padding: 3px; z-index: 1000;"><pre style="text-align: left; font: normal 10px Courier; color: #000000;">';
    if ( is_array($var) || is_object($var) ) print_r($var);
    else var_dump($var);
    print '</pre></div>';
    if ( $exit ) exit;
}

require_once WU_PATH_CONN.'Orders.php';
$CMF = new Orders();

$CMF->Log("\n\n", 'orders');
$CMF->Log('---------- Begin orders ----------', 'orders');

$CMF->ProcessOrders();
$CMF->ProcessStatuses();

$CMF->Log('---------- End orders ----------', 'orders');

$CMF->pdo->exec("UPDATE wuModShopSettings SET value={$CMF->ustamp} WHERE name='importOrders' LIMIT 1");

ReleaseLock($lock, $lockfile);

function AcquireLock(&$lock, $name)
{
    if ( !file_exists(PATH_LOCK) ) mkdir(PATH_LOCK, 0777, true);
    if ( !$lock = fopen(PATH_LOCK."$name.cron", 'a') ) return false;
    $i = 1;
    while ( $i++ < 5 )
    {
        if ( flock($lock, LOCK_EX | LOCK_NB) ) return true;
        usleep(50+rand(0,100));
    }
    fclose($lock);
    return false;
}

function ReleaseLock($lock, $name)
{
    if ( !$lock || !is_resource($lock) ) return;
    fclose($lock);
    if ( file_exists(PATH_LOCK."$name.cron") ) unlink(PATH_LOCK."$name.cron");
}