<?php

function testData($data)
{
	$num = count($data);
	echo "<p> $num полей в строке $row: <br /></p>\n";
	$row++;
	for ($c=0; $c < $num; $c++) {
		echo $data[$c] . "<br />\n";
	}
	
}
function testGetDifferendProducts($id)
{
	echo '<table><tbody>';
	echo '<tr>';
	echo '<td>№</td>'; 
	echo '<td>id-id1</td>'; 
	echo '<td>Модель</td>'; 
	echo '<td>Размер</td>'; 
	echo '<td>Цвет</td>'; 
	echo '</tr>';
	$i =1;
	foreach (getDifferendProducts($id) as $value) {
		echo '<tr>';
		echo '<td>', $i,  '</td>'; 
		echo '<td>', $value['id'] , '-', $value['id1'],  '</td>'; 
		echo '<td>', mb_strtolower($value['name'] . ' ' .  $value['color']),  '</td>'; 
		echo '<td>', $value['size'],  '</td>'; 
		echo '<td>', $value['color'],  '</td>'; 
		echo '</tr>';
		$i++;
	}
	echo '</tbody></table>';
}

function writeStatusProgress($message, $flag = FILE_APPEND)
{
	$log = "#" . date("Y-m-d H:i:s - ") . $message . PHP_EOL;
	$path = JPATH_BASE . DS .'TEMP'. DS . "status_progress.php";
	
	
	if($flag === 0 || !is_file($path)){
		$handle = fopen($path, 'w+');
		if ($handle) {
			fwrite($handle, $log);
			fclose ($handle);
		}
		
	} else {
		file_put_contents($path, $log, $flag | LOCK_EX);
	}
}
function writeLatId1($message, $flag = FILE_APPEND) 
{	
	$path = JPATH_BASE . DS .'TEMP'. DS . "last_id1.php";
	$handle = fopen($path, 'w+');
	if ($handle) {
		fwrite($handle, $message);
		fclose ($handle);
	}

}
