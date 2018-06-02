<?php

define('SOAP_LOGIN', 'web_site');
define('SOAP_PASS', '159753');
define('SOAP_URL', 'http://sergio-cotti1c.no-ip.org:80/to_site/ws/site_query.1cws?wsdl');
define('SITEID', 1);

require_once WU_PATH_CMF.'wuCore.php';

class Orders extends wuCore
{
    private $set;

    public function __construct()
    {
        parent::__construct();

        $this->pdo->exec("set session wait_timeout=10000,interactive_timeout=10000,net_read_timeout=10000");

        $this->set = $this->pdo->query('SELECT name,value FROM wuModShopSettings WHERE siteID='.SITEID)->fetchAll(PDO::FETCH_COLUMN | PDO::FETCH_UNIQUE);

        $this->statuses = array(
            'Новый' => 'new',
            'Принят' => 'accept',
            'В Обработке' => 'processing',
            'Отправлен' => 'send',
            'Отклонен' => 'declined',
            'Оплачен' => 'paid',
            'Не оплачен' => 'unpaid',
            'Истек' => 'expired'
        );
    }

    public function __get($name)
    {
        switch ( $name )
        {
        case 'soap':
            try
            {
                ini_set("soap.wsdl_cache_enabled", "0");

                $this->soap = @new SoapClient(SOAP_URL, array(
                    'authentication' => SOAP_AUTHENTICATION_BASIC,
                    'login' => SOAP_LOGIN,
                    'password' => SOAP_PASS,
                    'connection_timeout' => 600
                ));
            }
            catch ( SoapFault $e ) {
                $this->Log($e->faultcode.': '.$e->faultstring, 'orders');
                exit;
            }
            return $this->soap;
        }
        parent::__get($name);
        if ( isset($this->$name) ) return $this->$name;
    }

    /**
     * Отправка заказов в 1С
     */
    public function ProcessOrders()
    {
        $items = array();
        $orders = $this->pdo->query('SELECT orderID,o.*,u.userLastname,u.userFirstname,u.userMiddlename,u.userEmail,u.userPhone,u.userDtAdd FROM wuModShopOrders AS o
            LEFT JOIN wuUsers AS u USING(userID)
            WHERE orderDt1C IS NULL')->fetchAll(PDO::FETCH_UNIQUE | PDO::FETCH_ASSOC);

        if ( $orders )
            $items = $this->pdo->query('SELECT i.orderID,i.itemQuantity,i.itemPrice,k.kindCode,p.productCode FROM wuModShopOrdersItems AS i
                LEFT JOIN wuModShopKinds AS k ON i.kindID=k.kindID
                LEFT JOIN wuModShopProducts AS p ON i.productID=p.productID
                WHERE orderID IN ('.implode(',', array_keys($orders)).')')->fetchAll(PDO::FETCH_ASSOC | PDO::FETCH_GROUP);

        $data = array();
        foreach ( $orders AS $oid => $oval )
        {
            if ( !isset($items[$oid]) ) continue;
            $manager = '';

            $tmp = array(
                'order_id' => $oval['orderID'],
                'id_price' => $oval['orderColumn'],
                'client_id' => $oval['userID'],
                'client_name' => $oval['userLastname'].' '.$oval['userFirstname'].' '.$oval['userMiddlename'],
                'client_email' => $oval['userEmail'],
                'client_reg' => $oval['userDtAdd'],
                'client_phone' => $oval['userPhone'],
                'order_pm' => $oval['orderPayment'],
                'order_sm' => $oval['orderShipping'],
                'order_phone' => $oval['orderPhone'],
                'order_address' => $oval['orderShipStreet'],
                'order_name' => $oval['orderShipName'],
                'order_email' => $oval['orderEmail'],
                'order_comment' => $oval['orderComment'],
                'order_manager' => $manager,
                'items' => array()
            );

            foreach ( $items[$oid] AS $i )
                $tmp['items'][] = array(
                    'id' => $i['productCode'],
                    'id1' => $i['kindCode'],
                    'qnt' => $i['itemQuantity'],
                    'price' => $i['itemPrice']
                );
            $data[] = $tmp;
        }

        $ins = 0;
        if ( $data )
        {
            $params = array(
                'orderdata' => json_encode($data)
            );

            $response = $this->GetSoapMethod('orders', $params);
			
            if ( $data = json_decode($response->return, true) )
            {
                foreach ( $data AS $v )
                {
                    if ( !empty($v['status']) && isset($this->statuses[$v['status']]) && !empty($v['order_id']) )
                    {
                        $details = $this->pdo->quote("N декларации: {$v['declar']}\nТранспортная компания: {$v['transport']}\nГород: {$v['sity']}\nСклад: {$v['sklad']}\n");
                        $manager = isset($v['order_manager']) ? $v['order_manager'] : '';
                        $sthu = $this->pdo->prepare('UPDATE wuModShopOrders SET orderManager='.$this->pdo->quote($manager).',orderDetails='.$details.',orderStatus="'.$this->statuses[$v['status']].'",orderDt1C="'.$this->datetime.'" WHERE orderID='.(int)$v['order_id'].' LIMIT 1');
                        $sthu->execute();
                        if ( $sthu->rowCount() ) $ins++;
                    }
                }
            }
        }
        $this->Log("Orders ins: $ins", 'orders');
    }

    /**
     * Синхронизация статусов заказов с 1С
     */
    public function ProcessStatuses()
    {
        $time1 = $this->set['importOrders'] ? (int)$this->set['importOrders'] : $this->ustamp-86400;
        $time2 = $this->ustamp+86400;

        $params = array(
            'data1' => date('Y-m-d\TH:i:s', $time1),
            'data2' => date('Y-m-d\TH:i:s', $time2)
        );
        $upd = 0;
        $response = $this->GetSoapMethod('getorderstatus', $params);
        if ( $data = json_decode($response->return, true) )
        {
            foreach ( $data AS $v )
            {
                if ( !empty($v['status']) && isset($this->statuses[$v['status']]) && !empty($v['order_id']) )
                {
                    $manager = isset($v['order_manager']) ? $v['order_manager'] : '';
                    $details = $this->pdo->quote("N декларации: {$v['declar']}\nТранспортная компания: {$v['transport']}\nГород: {$v['sity']}\nСклад: {$v['sklad']}\n");
                    $sthu = $this->pdo->prepare('UPDATE wuModShopOrders SET orderManager='.$this->pdo->quote($manager).',orderDetails='.$details.',orderStatus="'.$this->statuses[$v['status']].'",orderDt1C="'.$this->datetime.'" WHERE orderID='.(int)$v['order_id'].' LIMIT 1');
                    $sthu->execute();
                    if ( $sthu->rowCount() ) $upd++;
                }
            }
        }
        $this->Log("Orders sync (".date("d-m-Y H:i:s", $time1)."-".date("d-m-Y H:i:s", $time2)."): $upd", 'orders');
    }

    /**
     * Вызов SOAP метода
     *
     * @param string $method     Имя метода
     * @param array  $params     Набор параметров
     */
    private function GetSoapMethod($method, $params = false)
    {
        try
        {
            $soap = @$this->soap->$method($params);

            return $soap;
        }
        catch ( SoapFault $e ) {
            $this->Log($e->faultcode.': '.$e->faultstring, 'orders');
            exit;
        }
    }
}