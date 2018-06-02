<?php 
class ModelExtensionModuleNewsletters extends Model{
	public function subscribes($data){
		$check = $this->db->query("SELECT * FROM " . DB_PREFIX . "newsletter WHERE `news_email`='" . $data['email'] . "'");

		if($check->num_rows){
			return "Email Already Exist!";
		}else{

			if($this->db->query("INSERT INTO " . DB_PREFIX . "newsletter (news_email, news_added) VALUES ('" . $data['email'] . "', NOW() )")){
				return "Subscription Successfull";
			}else{
				return "Subscription Fail";
			}
		}
	}	
}