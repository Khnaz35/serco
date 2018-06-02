<?php
class ControllerExtensionModuleWallcategory extends Controller {
	public function index($setting) {
		static $module = 0;
		$this->load->model('tool/image');
		$this->load->model('catalog/category');
		$subCatLimit = $setting['limit'];
		
		if (isset($setting['wall_category'])) {
			$categories = $setting['wall_category'];
		} else {
			$categories = array();
		}
		if (!empty($categories)){
			foreach ($categories as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			} 
			array_multisort($sort_order, SORT_ASC, $categories);
		}

		$cat = array();
        $count = 1;
		foreach($categories as $category){
                $currentCategory = $this->model_catalog_category->getCategory($category['category']);
					if($currentCategory) {
							$cat[$count]['category_id'] = $currentCategory['category_id'];
							$cat[$count]['name'] = $currentCategory['name'];
							//$cat[$count]['description'] = utf8_substr(strip_tags(html_entity_decode($currentCategory['description'], ENT_QUOTES, 'UTF-8')), 0, 220) . ($currentCategory['description'] && 220 > 0 ? '...' : '');
							$cat[$count]['href'] = $this->constructPath($category['category']);
							
                            if($category['image'] == ''){
							     $cat[$count]['image'] =  $this->model_tool_image->resize('placeholder.png', 800, 800);
							} 
                            else {
							     $cat[$count]['image'] = $this->model_tool_image->resize($category['image'], 800, 800);
							}
							
							$cat[$count]['category'] = $category['category'];
							/*$CategoryChildren = array();
							$Children = $this->model_catalog_category->getCategories($category['category']);
							$Children = array_slice($Children, 0, $subCatLimit);
							foreach($Children as $child){
								 if($child['image'] == ''){
							         $child['image'] =  $this->model_tool_image->resize('placeholder.png', 800, 800);
								} else {
									$child['image'] = $this->model_tool_image->resize($child['image'], 800, 800);
								}
							
								$CategoryChildren[] = array(
									'category_id' 	=> $child['category_id'],
									'name'        	=> $child['name'],
									'image'        	=> $child['image'],
									'href'         	=> $this->constructPath($category['category'], $child['category_id'])
								);
							}
							$cat[$count]['children'] = $CategoryChildren;*/
							
				}
			
                $count++;
            }
			$data['categories'] = $cat;
			$data['limit_column'] 		= $setting['limit_column'];
			$data['limit_column_child'] = $setting['limit_column_child'];
			
		$this->load->model('catalog/manufacturer');
		if (isset($setting['wall_manufactures'])) {
			$wall_manufactures = $setting['wall_manufactures'];
		} else {
			$wall_manufactures = '';
		}
		if (!empty($wall_manufactures)){
			foreach ($wall_manufactures as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			} 
			array_multisort($sort_order, SORT_ASC, $wall_manufactures);
		}
		$data['manufacturers'] = array();

		if($wall_manufactures) {
			foreach ($wall_manufactures as $manufacturer) {
				$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer['manufacturer_id']);

				if($manufacturer_info) {
					$data['manufacturers'][] = array(
						'manufacturer_id' => $manufacturer_info['manufacturer_id'],
						'name'            => $manufacturer_info['name'],
						'href'            => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer_info['manufacturer_id']),
						'thumb'           => $this->model_tool_image->resize(($manufacturer['image']=='' ? 'no_image.jpg' : $manufacturer['image']), 340, 200)
						);
				}
			}
		}
		$data['module'] = $module++;
		$data['lang_id'] = $this->config->get('config_language_id');
		$data['heading_title'] = $setting['title_name'];	
		
		return $this->load->view('extension/module/wallcategory', $data);
	}
	 protected function constructPath($categoryID,$subCategoryID = '') {
            if($subCategoryID != ''){
                $new_path = $categoryID . '_' . $subCategoryID;
            } else {
                $new_path = $categoryID;
            }
                $categoryURL = $this->url->link('product/category', 'path=' . $new_path);
		
		return $categoryURL;
        }
}