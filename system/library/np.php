<?php 
class NP 
{ 
	private $api = array(
		'key' => '225d9c5290c67fdc77c90ad90c7d42b4'
	);
	private $cache;
	private $cache_prefix = 'np';
 
    public function __construct() 
    { 
		$this->cache = new Cache('file', 60*60*24*30);
    } 
	public function getSities($data = array())
	{
		return $this->request('Address', 'getCities', $data);
	}
	
	public function getDepartments($data = array())
	{

		return $this->request('AddressGeneral', 'getWarehouses', $data);
	}
	public function getDepartmentsForSelect($data = array())
	{
		$result = array();
		foreach ($this->getDepartments($data) as $value) {
			$result[] = array(
				'name' => $value['DescriptionRu'],
				'city_id' => $value['CityID'],
				'ref' => $value['Ref'],

			);
		}
		return $result;
	}
	public function getSitiesForSelect($data = array())
	{
		$result = array();
		foreach ($this->getSities($data) as $value) {
			$result[] = array(
				'name' => $value['DescriptionRu'],
				'city_id' => $value['CityID'],
				'ref' => $value['Ref'],

			);
		}
		return $result;
	}
//	https://devcenter.novaposhta.ua/docs/services/556d7ccaa0fe4f08e8f7ce43/operations/556d8211a0fe4f08e8f7ce45
	
	public function request($modelName, $calledMethod, array $data)
	{
		$result = array();
		
		$cache_key = $this->cache_prefix . '.' . $modelName . '.' . $calledMethod;
		
		if(!empty($data)){
			$tmp_key = '.' . json_encode($data);
			$tmp_key = preg_replace('/"|\{|\}/', '', $tmp_key);
			$cache_key .= preg_replace('/:|,/', '.', $tmp_key);
		}
		
		if($this->cache->get($cache_key)){
			return $this->cache->get($cache_key);
		} else {
			$ch = curl_init();

			$json = array(
				'modelName' => $modelName,
				'calledMethod' => $calledMethod,
			);

			foreach ($data as $key => $value) {
				$json[$key] = $value;
			}
			$json['apiKey'] = $this->api['key'];

			curl_setopt($ch, CURLOPT_URL, 'https://my.novaposhta.ua/data/get/container/JSON');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
			curl_setopt($ch, CURLOPT_HTTPHEADER, Array("Content-Type: application/json"));
			curl_setopt($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($json));
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
			$response = curl_exec($ch);
			$result = json_decode($response, true);
			curl_close($ch);
			if(!empty($result['success'])){
				$result = $result['data'];
				$this->cache->set($cache_key, $result);
			} elseif(!empty($result['errors'])) {
				$result = array();
			}

			return $result;
		}

	}

} 
