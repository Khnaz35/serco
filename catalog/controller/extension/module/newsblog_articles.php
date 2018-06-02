<?php
class ControllerExtensionModuleNewsBlogArticles extends Controller {

	public function index($setting) {        

		$this->load->language('module/newsblog_articles');

		$this->load->model('newsblog/article');

		if($setting['show_title']){
      		$data['heading_title'] = $setting['name'];
		}else{
      		$data['heading_title'] = false;
		}

		$data['text_more'] = $this->language->get('text_more');
		$data['text_date_added'] = $this->language->get('text_date_added');
		$data['articles'] = array();

		$category_id	= $setting['main_category_id'];
		$sort			= $setting['sort_by'];
		$order			= $setting['sort_direction'];

		$filter_data = array(
					'filter_category_id' => $category_id,
					'sort'               => $sort,
					'order'              => $order,
					'start'              => 0,
					'limit'              => $setting['limit']
		);

		$data['link_to_category'] = false;
		if ($category_id) {
            $data['link_to_category'] = $this->url->link('newsblog/category', 'newsblog_path=' . $category_id);
        }

		$results = $this->model_newsblog_article->getArticles($filter_data);

		$this->load->model('tool/image');

		foreach ($results as $result) {
			if ($result['image']) {
 				$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
 			} else {
 				$image = false;
 			}

 			$mainCategoryId =  $this->model_newsblog_article->getArticleMainCategoryId($result['article_id']);
            
            $month_title = $this->get_month_title(date($this->language->get('date_format_short'), strtotime($result['date_available'])));
            
			$data['articles'][] = array(
				'name'        		=> $result['name'],
				'thumb' 			=> $image,
				//'viewed' 			=> sprintf($this->language->get('text_viewed'), $result['viewed']),
				'preview'  		    => utf8_substr(strip_tags(html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8')), 0, $setting['desc_limit']),
				'href'         		=> $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $result['article_id']),
				'date'   			=> $month_title
			);
		}
        
		$template='newsblog_articles.tpl';
		if ($setting['template']) $template=$setting['template'];

		return $this->load->view('extension/module/'.$template, $data);

	}
    
    function get_month_title($date){
        $month_title_array['01'] = 'января';
        $month_title_array['02'] = 'февраля';
        $month_title_array['03'] = 'марта';
        $month_title_array['04'] = 'апреля';
        $month_title_array['05'] = 'мая';
        $month_title_array['06'] = 'июня';
        $month_title_array['07'] = 'июля';
        $month_title_array['08'] = 'августа';
        $month_title_array['09'] = 'сентября';
        $month_title_array['10'] = 'октября';
        $month_title_array['11'] = 'ноября';
        $month_title_array['12'] = 'декабря';
        
        $date_arr = explode('.', $date);
        $new_date = $date_arr[0] . ' ' . $month_title_array[$date_arr[1]] . ', ' . $date_arr[2];
        
        return $new_date;
    }
}
