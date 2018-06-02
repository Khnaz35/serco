<?php
class ModelToolNP extends Model {
	private $np;
	
	
	public function __construct($registry)
	{
		$this->np = new NP();
		parent::__construct($registry);
	}
	

	
	public function getCities($data = array())
	{
		$sql = "SELECT * FROM " . DB_PREFIX . "np_cities c WHERE 1=1";

		if (!empty($data['name'])) {
//			$sql .= " AND c.DescriptionRu LIKE '%" . $this->db->escape($data['name']) . "%' ";
			$sql .= " AND c.DescriptionRu LIKE '" . $this->db->escape($data['name']) . "%' ";
		}
		if (!empty($data['Ref'])) {
			$sql .= " AND c.Ref='" . $this->db->escape($data['Ref']) . "' ";
		}

		$sql .= " ORDER BY c.DescriptionRu";

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if (empty($data['start']) || $data['start'] < 1) {
				$data['start'] = 0;
			}

			if (empty($data['limit']) || $data['limit'] < 1) {
				$data['limit'] = 10;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	
	public function getDepartments($data = array())
	{
		$sql = "SELECT * FROM " . DB_PREFIX . "np_departments d WHERE 1=1";

		if (!empty($data['name'])) {
			$sql .= " AND d.DescriptionRu LIKE %'" . $this->db->escape($data['name']) . "%' ";
		}
		if (!empty($data['Ref'])) {
			$sql .= " AND d.Ref='" . $this->db->escape($data['Ref']) . "' ";
		}
		if (!empty($data['CityRef'])) {
			$sql .= " AND d.CityRef='" . $this->db->escape($data['CityRef']) . "' ";
		}

		$sql .= " ORDER BY d.Number";

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if (empty($data['start']) || $data['start'] < 1) {
				$data['start'] = 0;
			}

			if (empty($data['limit']) || $data['limit'] < 1) {
				$data['limit'] = 10;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		} 

		$query = $this->db->query($sql);

		return $query->rows;
	}
	public function addCities()
	{
		$cities = $this->np->getSities();
		$j = 0;
			foreach ($cities as $city) {
				if(!empty($city) || count($city) < 10) {
					continue;
				} 
				$sql = "INSERT INTO `" . DB_PREFIX . "np_cities` SET ";
				$i = 0; $city_li = count($city) - 1;
				foreach ($city as $key => $value) {
					if(!empty($value)){
						if($key == 'CityID'){
							$sql .= "`" . $key . "`='" . (int)$value . "'";
						} else {
							$sql .= "`" . $key . "`='" . $this->db->escape($value) . "'";
						}
					
						if($city_li > $i){
							$sql .= ",";
						}
						$sql .= " ";
					}
					$i++;
				}
				$this->db->query($sql);
				$j++;
			}

	}
	public function addDepartments()
	{
		$departments = $this->np->getDepartments();
		$ints = array(
			'SiteKey',
			'Number',
			'PostFinance',
			'BicycleParking',
			'PaymentAccess',
			'POSTerminal',
			'InternationalShipping',
			'TotalMaxWeightAllowed',
			'PlaceMaxWeightAllowed',
		);
		
//		var_dump(count($departments));
//		die;
		foreach ($departments as $department) {
			$sql = "INSERT INTO `" . DB_PREFIX . "np_departments` SET ";
			$i = 0; $department_li = count($department) - 1;
			foreach ($department as $key => $value) {
				if(!empty($value)){
					if(!is_array($value)){
						if(in_array($key, $ints)){
							$sql .= "`" . $key . "`='" . (int)$value . "'";
						} else {
							$sql .= "`" . $key . "`='" . $this->db->escape($value). "'";
						}

						if($department_li > $i){
							$sql .= ",";
						}
						$sql .= " ";
					}
				}
				$i++;
			}
			$sql = preg_replace('/(,\s)*$/', '', $sql);
			$this->db->query($sql);
		}

	}
	
	
	
	
	
	
	
	
	
	
	public function addDepartmentsTable($department)
	{
		$sql = "CREATE TABLE `" . DB_PREFIX . "np_departments` (
  `npd_id` int(11) NOT NULL,
  `SiteKey` int(11) NOT NULL DEFAULT '0',
  `Description` varchar(254) DEFAULT NULL,
  `DescriptionRu` varchar(254) DEFAULT NULL,
  `ShortAddress` varchar(254) DEFAULT NULL,
  `ShortAddressRu` varchar(254) DEFAULT NULL,
  `Phone` varchar(254) DEFAULT NULL,
  `TypeOfWarehouse` varchar(254) DEFAULT NULL,
  `Ref` varchar(254) DEFAULT NULL,
  `Number` int(11) NOT NULL DEFAULT '0',
  `CityRef` varchar(254) DEFAULT NULL,
  `CityDescription` varchar(254) DEFAULT NULL,
  `CityDescriptionRu` varchar(254) DEFAULT NULL,
  `Longitude` varchar(254) DEFAULT NULL,
  `Latitude` varchar(254) DEFAULT NULL,
  `PostFinance` int(11) NOT NULL DEFAULT '0',
  `BicycleParking` int(11) NOT NULL DEFAULT '0',
  `PaymentAccess` int(11) NOT NULL DEFAULT '0',
  `POSTerminal` int(11) NOT NULL DEFAULT '0',
  `InternationalShipping` int(11) NOT NULL DEFAULT '0',
  `TotalMaxWeightAllowed` int(11) NOT NULL DEFAULT '0',
  `PlaceMaxWeightAllowed` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `" . DB_PREFIX . "np_departments`
--
ALTER TABLE `" . DB_PREFIX . "np_departments`
  ADD PRIMARY KEY (`npd_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `" . DB_PREFIX . "np_departments`
--
ALTER TABLE `mil_oc_craft_np_departments`
  MODIFY `npd_id` int(11) NOT NULL AUTO_INCREMENT;";

	}
	public function addCytiesTable()
	{
		$sql = "CREATE TABLE `" . DB_PREFIX . "np_cities` (
		`npc_id` int(11) NOT NULL,
		`Description` varchar(254) NOT NULL DEFAULT '',
		`DescriptionRu` varchar(254) NOT NULL DEFAULT '',
		`Ref` varchar(254) NOT NULL DEFAULT '',
		`Delivery1` int(11) NOT NULL DEFAULT '0',
		`Delivery2` int(11) NOT NULL DEFAULT '0',
		`Delivery3` int(11) NOT NULL DEFAULT '0',
		`Delivery4` int(11) NOT NULL DEFAULT '0',
		`Delivery5` int(11) NOT NULL DEFAULT '0',
		`Delivery6` int(11) NOT NULL DEFAULT '0',
		`Delivery7` int(11) NOT NULL DEFAULT '0',
		`Area` varchar(254) DEFAULT NULL,
		`SettlementType` varchar(254) DEFAULT NULL,
		`PreventEntryNewStreetsUser` varchar(254) DEFAULT NULL,
		`Conglomerates` varchar(254) DEFAULT NULL,
		`CityID` int(11) NOT NULL DEFAULT '0',
		`SettlementTypeDescription` varchar(254) NOT NULL DEFAULT '',
		`SettlementTypeDescriptionRu` varchar(254) NOT NULL DEFAULT ''
	  ) ENGINE=InnoDB DEFAULT CHARSET=utf8; 
	  ALTER TABLE `" . DB_PREFIX . "np_cities` ADD PRIMARY KEY (`npc_id`); 
	  ALTER TABLE `" . DB_PREFIX . "np_cities`
		MODIFY `npc_id` int(11) NOT NULL AUTO_INCREMENT;";
		$this->db->query($sql);
	}
}
