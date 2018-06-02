<?php
function write_log($message){
	
	$timechange = time();
	$timechange_delete = $timechange - (86400 * 2);
	$date_delete = date( 'Y_m_d', $timechange_delete );
	$FILE_LOG_DELETE = 'com_record.'.$date_delete.'.php'; 
	if (file_exists (DIR_LOGS . $FILE_LOG_DELETE)){
		unlink(DIR_LOGS . $FILE_LOG_DELETE);
	}
	
	$ERROR_LOGS = 'com_record.'.date('Y_m_d').'.php';
	$file = DIR_LOGS . $ERROR_LOGS;
	$hangle = fopen ($file, 'a+');
	fwrite($hangle,date('Y-m-d G:i:s') . '        ' . print_r($message, true) . "\n");
	fclose($hangle);
	
}

function getLastId($table, $column){
global $db;
		
		$getLastId = $db->query("SELECT " . $column . " FROM " . $table . " ORDER BY " . $column . " DESC LIMIT 1");
        return $getLastId->row[$column];

}

function insertObject($table, &$object, $key = null){
global $db;	
		$fields = array();
		$values = array();
		$results = '';
		$num = 0;
		// Iterate over the object variables to build the query fields and values.
		foreach (get_object_vars($object) as $k => $v)
		{
			if (is_array($v) or is_object($v) or $v === null)
			{
				continue;
			}
			if ($k[0] == '_')
			{
				continue;
			}
			$fields[] = $k;
			$values[] = $v;
		}
		
		foreach (get_object_vars($object) as $k => $v)
		{
			// Only process non-null scalars.
			if (is_array($v) or is_object($v) or $v === null)
			{
				continue;
			}
			// Ignore any internal fields.
			if ($k[0] == '_')
			{
				continue;
			}
			// Prepare and sanitize the fields and values for the database query.

				$results .= "`";
				$results .= $k;
				$results .= "`";
				$results .= "=";
				$results .= "'";
				$results .= $v;
				$results .= "'";
				$num = $num+1;
						if ($num != count($fields)) {
							$results .= " ,";
						}	
			
		}
	$db->query( "INSERT INTO " . $table . " SET " . $results . "" );
	
	
	if ($key && is_string($key))
		{
			$results = '';
			$num = 0;
			foreach (get_object_vars($object) as $k => $v)
			{	
				if (is_array($v) or is_object($v) or $v === null)
				{
					continue;
				}
				if ($k[0] == '_')
				{
					continue;
				}
				if ($k != $key){
				$results .= "`";
				$results .= $k;
				$results .= "`";
				$results .= "=";
				$results .= "'";
				$results .= $v;
				$results .= "'";
				$num = $num+1;
						if ($num != (count($fields))) {
							$results .= " and ";
						}
				}
			}
				
			$id_query = $db->query ( "SELECT  " . $key . " FROM " . $table . " where " . $results . "" );
			$id = $id_query->row[$key];
			$object->$key = $id;
		}
	
}


function dsCrypt($input,$decrypt=false) {
    $o = $s1 = $s2 = array(); 
    $basea = array('?','(','@',';','$','#',"]","&",'*'); 
    $basea = array_merge($basea, range('a','z'), range('A','Z'), range(0,9) );
    $basea = array_merge($basea, array('!',')','_','+','|','%','/','[','.',' ') );
    $dimension=9; 
    for($i=0;$i<$dimension;$i++) { 
        for($j=0;$j<$dimension;$j++) {
            $s1[$i][$j] = $basea[$i*$dimension+$j];
            $s2[$i][$j] = str_rot13($basea[($dimension*$dimension-1) - ($i*$dimension+$j)]);
        }
    }
    unset($basea);
    $m = floor(strlen($input)/2)*2; 
    $symbl = $m==strlen($input) ? '':$input[strlen($input)-1]; 
    $al = array();
    
    for ($ii=0; $ii<$m; $ii+=2) {
        $symb1 = $symbn1 = strval($input[$ii]);
        $symb2 = $symbn2 = strval($input[$ii+1]);
        $a1 = $a2 = array();
        for($i=0;$i<$dimension;$i++) { 
            for($j=0;$j<$dimension;$j++) {
                if ($decrypt) {
                    if ($symb1===strval($s2[$i][$j]) ) $a1=array($i,$j);
                    if ($symb2===strval($s1[$i][$j]) ) $a2=array($i,$j);
                    if (!empty($symbl) && $symbl===strval($s2[$i][$j])) $al=array($i,$j);
                }
                else {
                    if ($symb1===strval($s1[$i][$j]) ) $a1=array($i,$j);
                    if ($symb2===strval($s2[$i][$j]) ) $a2=array($i,$j);
                    if (!empty($symbl) && $symbl===strval($s1[$i][$j])) $al=array($i,$j);
                }
            }
        }
        if (sizeof($a1) && sizeof($a2)) {
            $symbn1 = $decrypt ? $s1[$a1[0]][$a2[1]] : $s2[$a1[0]][$a2[1]];
            $symbn2 = $decrypt ? $s2[$a2[0]][$a1[1]] : $s1[$a2[0]][$a1[1]];
        }
        $o[] = $symbn1.$symbn2;
    }
    if (!empty($symbl) && sizeof($al)) 
        $o[] = $decrypt ? $s1[$al[1]][$al[0]] : $s2[$al[1]][$al[0]];
    return implode('',$o);
}

$dm = '34D39*4V!UL!17?986';
$dmw = 'XXE$34D39*4V!UL!17?986';

function connecting ($print_key){

	if (($print_key == 'ceaf4249af9153a20c5168bf1bf98b51') or ($print_key == '689241223f6e91e07deec327898a89cf')) {
		return (string)dsCrypt("E28V76/",1);
	}
}

function rus2translit($string) {
    $converter = array(
        'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'g',   'д' => 'd',   'е' => 'e',
        'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
        'и' => 'i',   'й' => 'y',   'к' => 'k',
        'л' => 'l',   'м' => 'm',   'н' => 'n',
        'о' => 'o',   'п' => 'p',   'р' => 'r',
        'с' => 's',   'т' => 't',   'у' => 'u',
        'ф' => 'f',   'х' => 'h',   'ц' => 'c',
        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
        'ь' => '\'',  'ы' => 'y',   'ъ' => '\'',
        'э' => 'e',   'ю' => 'yu',  'я' => 'ya',
        
        'А' => 'A',   'Б' => 'B',   'В' => 'V',
        'Г' => 'G',   'Д' => 'D',   'Е' => 'E',
        'Ё' => 'E',   'Ж' => 'Zh',  'З' => 'Z',
        'И' => 'I',   'Й' => 'Y',   'К' => 'K',
        'Л' => 'L',   'М' => 'M',   'Н' => 'N',
        'О' => 'O',   'П' => 'P',   'Р' => 'R',
        'С' => 'S',   'Т' => 'T',   'У' => 'U',
        'Ф' => 'F',   'Х' => 'H',   'Ц' => 'C',
        'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Sch',
        'Ь' => '\'',  'Ы' => 'Y',   'Ъ' => '\'',
        'Э' => 'E',   'Ю' => 'Yu',  'Я' => 'Ya',
    );
    return strtr($string, $converter);
}

function str2url($str) {
    // переводим в транслит
    $str = rus2translit($str);
    // в нижний регистр
    $str = strtolower($str);
    // заменям все ненужное нам на "-"
    $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);
    // удаляем начальные и конечные '-'
    $str = trim($str, "-");
    return $str;
}

class ModuleSeoUrlGenerator {
    
        public function seoUrlGenerateAjax($query_part,$seos,$only_to_latin = FALSE){
            $result = '';
            if($seos){
                $name = $seos;
                    $name = html_entity_decode($name,ENT_QUOTES);
                    $name = strip_tags($name);
                    $name = trim($name);
                    if($name){
                        $result = $this->generate($query_part,$name,array(),$only_to_latin);
                    }
                
            }
            return $result;
        }
		
		protected function generate($query_part,$name,$url_part_last=array(),$only_to_latin){
            global $db;
			$keyword = $this->validateUrl($name,$only_to_latin);
            $dublicate = '';
            if($keyword){
                $where = " WHERE keyword='".$keyword."' AND query LIKE '".$query_part."%'";
                //$where = " WHERE keyword='".$keyword."' ";
                $sql = "SELECT * FROM `" . DB_PREFIX . "url_alias` ".$where;
                $query = $db->query($sql);
                if($query->row){
                    $url_part = explode('-', $query->row['keyword']);
                    $dublicate = TRUE;
                    if($url_part && is_array($url_part)){
                        $name = '';
                        if((int)end($url_part)>0){
                            $end = '-'.((int)end($url_part)+1);
                            array_pop($url_part);
                        }else{
                            $end = '-1';
                        }
                        $name = implode('-', $url_part);
                        
                    }else{
                        $end = '-1';
                    }
                    $name = $name.$end;
                    $keyword = $this->generate($query_part,$name,$url_part_last,$only_to_latin);
                }
                while (isset($url_part_last[$keyword])) {
                    $url_part = explode('-', $keyword);
                    if($url_part && is_array($url_part)){
                        $keyword = '';
                        if((int)end($url_part)>0){
                            $end = '-'.((int)end($url_part)+1);
                            array_pop($url_part);
                        }else{
                            $end = '-1';
                        }
                        $keyword = implode('-', $url_part);
                        
                    }else{
                        $end = '-1';
                    }
                    $keyword = $keyword.$end;
                }
            }
            $url = $keyword;
            return $url;
        }
        
        protected function validateUrl($string,$only_to_latin=FALSE){
            
            $string = html_entity_decode($string,ENT_QUOTES);
            $string = strip_tags($string);
            $string = trim($string);
            
            $arr = explode(" ", $string);
            $str = '';
            for($i=0;$i<count($arr);$i++){
                $arr[$i] = trim($arr[$i]);
                if($arr[$i]){
                    $str .= ' '.$arr[$i];
                }
            }
            
            $str = trim($str);
            $find = array('«', '»','"', '&', '>', '<','`','&acute;','!', '^','*','$','\'','@','"', '±',' ','&','#',';','%','?',':','(',')','-','_','=','+','[',']',',','.','/','\\');
            $replace = array('','','','','','','','','','','','','','','','','-','','','','','','','','','-','-','-','-','','','-','','-','-');
            $str = str_replace($find, $replace, $str);
            $str = trim(mb_strtolower($str,'utf-8'));
            if($only_to_latin){
                $find = array('а','б','в','г','д','е', 'ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','ц','ч','ш','щ','у','ф','х','ъ','ь','ы','э','ю','я');
                //$replace = array('a','b','v','g','d','ye','yo','zh','z','i','yi','k','l','m','n','o','p','r','s','t','ts','ch','sh','sch','u','ph','kh','','','y','e','yu','ya');
                $replace = array('a','b','v','g','d','e','yo','zh','z','i','j','k','l','m','n','o','p','r','s','t','ts','ch','sh','sch','u','f','kh','','','y','e','yu','ya');
                $str = str_replace($find, $replace, $str);
            }
            return $str;
        }

}

?>