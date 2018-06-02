<?php
class ControllerNewsBlogArticle extends Controller {
	private $error = array();

	public function index() {
	   
       $this->document->addScript('catalog/view/javascript/share42/share42.js');
	   
		$this->load->language('newsblog/article');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('newsblog/category');

		$category_info = false;
		$settings = false;

		if (isset($this->request->get['newsblog_path'])) {
			$newsblog_path = '';

			$parts = explode('_', (string)$this->request->get['newsblog_path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $newsblog_path_id) {

				if (!$newsblog_path) {
					$newsblog_path = $newsblog_path_id;
				} else {
					$newsblog_path .= '_' . $newsblog_path_id;
				}

				$category_info = $this->model_newsblog_category->getCategory($newsblog_path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $newsblog_path)
					);
				}
			}

			$images_size_articles_big=array($this->config->get($this->config->get('config_theme') . '_image_popup_width'),$this->config->get($this->config->get('config_theme') . '_image_popup_height'));
		  	$images_size_articles_small=array($this->config->get($this->config->get('config_theme') . '_image_thumb_width'),$this->config->get($this->config->get('config_theme') . '_image_thumb_height'));

			// Set the last category breadcrumb
			$category_info = $this->model_newsblog_category->getCategory($category_id);

			if ($category_info) {
				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['newsblog_path'])
				);

	            //for no errors with versions < 20160920
				if ($category_info['settings']) {
					$settings=unserialize($category_info['settings']);

		            $images_size_articles_big=array($settings['images_size_articles_big_width'],$settings['images_size_articles_big_height']);
		            $images_size_articles_small=array($settings['images_size_articles_small_width'],$settings['images_size_articles_small_height']);
	            }
			}
		}

		if (isset($this->request->get['newsblog_article_id'])) {
			$newsblog_article_id = (int)$this->request->get['newsblog_article_id'];
		} else {
			$newsblog_article_id = 0;
		}

		$this->load->model('newsblog/article');

		$article_info = $this->model_newsblog_article->getArticle($newsblog_article_id);

		if ($article_info) {
			$url = '';

			if (isset($this->request->get['newsblog_path'])) {
				$url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $article_info['name'],
				'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $newsblog_article_id)
			);

			if ($article_info['meta_title']) {
				$this->document->setTitle($article_info['meta_title']);
			} else {
				$this->document->setTitle($article_info['name']);
			}

			$this->document->setDescription($article_info['meta_description']);
			$this->document->setKeywords($article_info['meta_keyword']);
			$this->document->addLink($this->url->link('newsblog/article', 'newsblog_article_id=' . $newsblog_article_id), 'canonical');

			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

			if ($article_info['meta_h1']) {
				$data['heading_title'] = $article_info['meta_h1'];
			} else {
				$data['heading_title'] = $article_info['name'];
			}

			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_share'] = $this->language->get('text_share');


			if ($settings && $settings['show_preview'])
			$data['preview'] = html_entity_decode($article_info['preview'], ENT_QUOTES, 'UTF-8');
			else
			$data['preview'] = '';

			$data['description'] = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');

			$this->load->model('tool/image');

			if ($article_info['image']) {
				$data['original']	= HTTP_SERVER.'image/'.$article_info['image'];
				$data['popup'] 		= $this->model_tool_image->resize($article_info['image'], $images_size_articles_big[0], $images_size_articles_big[1]);
				$data['thumb'] 		= $this->model_tool_image->resize($article_info['image'], $images_size_articles_small[0], $images_size_articles_small[1]);
			
                $data['share_image'] = HTTP_SERVER.'image/'.$article_info['image'];
            } else {
				$data['original'] 	= '';
				$data['popup'] 		= '';
				$data['thumb'] 		= '';
                
                $data['share_image'] = HTTP_SERVER.'image/' . $this->config->get('config_logo');
			}

			$data['images'] = array();

			$results = $this->model_newsblog_article->getArticleImages($newsblog_article_id);

			foreach ($results as $result) {
				$data['images'][] = array(
					'original'	=> HTTP_SERVER.'image/'.$result['image'],
					'popup' 	=> $this->model_tool_image->resize($result['image'], $images_size_articles_big[0], $images_size_articles_big[1]),
					'thumb' 	=> $this->model_tool_image->resize($result['image'], $images_size_articles_small[0], $images_size_articles_small[1])
				);
			}

			$data['articles'] = array();

			$results = $this->model_newsblog_article->getArticleRelated($newsblog_article_id);

			foreach ($results as $result) {

				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				$mainCategoryId =  $this->model_newsblog_article->getArticleMainCategoryId($result['article_id']);

                $month_title = $this->get_month_title(date($this->language->get('date_format_short'), strtotime($result['date_available'])));
            
				$data['articles'][] = array(
					'article_id'  => $result['article_id'],
					'name'        => $result['name'],
					'preview'     => html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8'),
                    'date'   	  => $month_title,
					'href'        => $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $result['article_id'])
				);
			}

			/*$data['tags'] = array();

			if ($article_info['tag']) {
				$tags = explode(',', $article_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}*/


			$this->model_newsblog_article->updateViewed($this->request->get['newsblog_article_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$template_default='article.tpl';
			if ($settings && $settings['template_article']) $template_default=$settings['template_article'];

			$this->response->setOutput($this->load->view('newsblog/'.$template_default, $data));
		} else {
			$url = '';

			if (isset($this->request->get['newsblog_path'])) {
				$url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $newsblog_article_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found.tpl', $data));
		}
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