<?php

class Orders
{
    private $set;
    private $order_data;
    private $soap;
    private $db;
    private $postfix = '-ru';
//    private $postfix = '-ua';


	private $soap_login = 'web_site';
	private $soap_pass = '159753';
	private $soap_url = 'http://sergio-cotti1c.no-ip.org:80/to_site/ws/site_query.1cws?wsdl';
	private $site_id = 1;
	private $size_option_id = 74;
	
	

    public function __construct($data, $db)
    {
		$this->order_data = $data;
		$this->db = $db;
		$this->initSoap();
    }

    protected function initSoap()
    {

		try
		{
			ini_set("soap.wsdl_cache_enabled", "0");

			$this->soap = @new SoapClient($this->soap_url, array(
				'authentication' => SOAP_AUTHENTICATION_BASIC,
				'login' => $this->soap_login,
				'password' => $this->soap_pass,
				'connection_timeout' => 600
			));
			return $this->soap;
		}
		catch ( SoapFault $e ) {
			file_put_contents(DIR_LOGS . 'error.log', date('Y-m-d H:i:s'). ' ' . $e . PHP_EOL, FILE_APPEND);
			$this->soap = false;
		}

    }

    /**
     * Отправка заказов в 1С
     */
    public function sendOrder()
    {
        $data = array();
            $manager = $this->order_data['store_url'];
			
			$tmp_order_id = $this->order_data['order_id'] . '';
			$order_id = substr('000000', strlen($tmp_order_id), 6) . $tmp_order_id ;
			
			$tmp = array(
                'order_id' => $order_id . $this->postfix,
                'id_price' => 1,
                'client_id' => $this->order_data['customer_id'],
                'client_name' =>  $this->order_data['payment_lastname'].' '. $this->order_data['payment_firstname'],
                'client_email' => $this->order_data['email'],
                'client_reg' => '',
                'client_phone' => $this->order_data['telephone'],
                'order_pm' => $this->order_data['payment_method'],
                'order_sm' => $this->order_data['shipping_method'],
                'order_phone' => $this->order_data['telephone'],
                'order_address' => $this->order_data['shipping_address_1'],
                'order_name' => $this->order_data['shipping_lastname'].' '. $this->order_data['shipping_firstname'],
                'order_email' => $this->order_data['email'],
                'order_comment' => $this->order_data['comment'],
                'order_manager' => $manager,
                'items' => array()
            );

            foreach ( $this->order_data['products'] as $product ){
				foreach ($product['option'] as $option) {
					if($option['option_id'] == $this->size_option_id){
						$sql = "SELECT DISTINCT `product_option_value_id`, `id_1c`, `id1_1c`"
							. " FROM `" . DB_PREFIX . "product_option_value`"
							. " WHERE `product_option_value_id` = '" . (int)$option['product_option_value_id'] . "' "
							. "AND  `id1_1c` > 0";
						$query = $this->db->query($sql);
						if($query->num_rows){
							$tmp['items'][] = array(
								'id' => $query->row['id_1c'],
								'id1' => $query->row['id1_1c'],
								'qnt' => $product['quantity'],
								'price' => $product['price']
							);
						}
					}
				}
			}
			if(!empty($tmp['items'])){
				$data[] = $tmp;
			}


        $ins = 0;
        if ( $data )
        {
            $params = array(
                'orderdata' => json_encode($data)
            );

	$path = DIR_LOGS . "last.log";
	$handle = fopen($path, 'w+');
	if ($handle) {
		fwrite($handle, print_r($params, true));
		fclose ($handle);
	}

	$response = $this->GetSoapMethod('orders', $params);
			
//            if ( $data = json_decode($response->return, true) )
//            {
//                foreach ( $data AS $v )
//                {
//                    if ( !empty($v['status']) && isset($this->statuses[$v['status']]) && !empty($v['order_id']) )
//                    {
//                        $details = $this->pdo->quote("N декларации: {$v['declar']}\nТранспортная компания: {$v['transport']}\nГород: {$v['sity']}\nСклад: {$v['sklad']}\n");
//                        $manager = isset($v['order_manager']) ? $v['order_manager'] : '';
//                        $sthu = $this->pdo->prepare('UPDATE wuModShopOrders SET orderManager='.$this->pdo->quote($manager).',orderDetails='.$details.',orderStatus="'.$this->statuses[$v['status']].'",orderDt1C="'.$this->datetime.'" WHERE orderID='.(int)$v['order_id'].' LIMIT 1');
//                        $sthu->execute();
//                        if ( $sthu->rowCount() ) $ins++;
//                    }
//                }
//            }
        }
//        $this->Log("Orders ins: $ins", 'orders');
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