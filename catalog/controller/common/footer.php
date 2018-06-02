<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

        $data['scripts'] = $this->document->getScripts('footer');
        $data['home']    = $this->url->link('common/home');
        $data['og_url']  = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
        $data['powered'] = sprintf($this->language->get('text_powered'), date('Y', time()), $this->config->get('config_name'));


        $data['text_contact'] = $this->language->get('text_contact');
        $data['text_logo']    = $this->language->get('text_logo');
        $data['text_dev']     = $this->language->get('text_dev');
        $data['informations'] = array();

        $this->load->model('catalog/information');

        foreach ($this->model_catalog_information->getInformations() as $information) {
            if ($information['bottom2'] || $information['bottom']) {
                $data['informations'][] = array(
                    'title' => $information['title'],
                    'href'  => $this->url->link('information/information', 'information_id=' . $information['information_id'])
                );
            }
        }

        //$data['text_social']  = $this->language->get('text_social');
        /*$data['testimonial'] = array(
            'title' => 'Отзывы о магазине',
            'href'  => $this->url->link('testimonial/testimonial')
        );*/

		/*foreach ($this->model_catalog_information->getInformations() as $information) {
			if ($information['information_id'] == 8) {

				$this->load->model('newsblog/category');
				$this->load->language('newsblog/category');

				$articles_id = 2; // ай-ди статей

				$articles_info = $this->model_newsblog_category->getCategory($articles_id);
				if ($articles_info) {
					$data['informations'][] = array(
						'title' => $articles_info['name'],
						'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $articles_id)
					);
				}

				$news_id = 1; //  ай-ди новостей

				$news_info = $this->model_newsblog_category->getCategory($news_id);
				if ($news_info) {
					$data['informations'][] = array(
						'title' => $news_info['name'],
						'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $news_id)
					);
				}

			}
			if ($information['bottom']) {
				$data['informations'][] = array(
					'title' => $information['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $information['information_id'])
				);
			}
		}*/


		// Menu 2
/*
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');

		$data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        if ($categories) {
    		foreach ($categories as $category) {
                    // Level 2
                    $children_data = array();

                    $children = $this->model_catalog_category->getCategories($category['category_id']);

                    foreach ($children as $child) {

                            // Level 3
                            $sub_children_data = array();

                            $sub_children = $this->model_catalog_category->getCategories($child['category_id']);

                            foreach ($sub_children as $sub_child) {

                                if ($sub_child['bottom']) {
                                    $data['categories'][] = array(
                                        'name'     => $sub_child['name'],
                                        'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $sub_child['category_id'])
                                    );
                                }
                            }

                        if ($child['bottom']) {
                            $data['categories'][] = array(
                                'name'     => $child['name'],
                                'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                            );
                        }
                    }

                if ($category['bottom']) {
                    // Level 1
                    $data['categories'][] = array(
                        'name'     => $category['name'],
                        'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
                    );
                }
    		}
        }*/

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

        $data['column_footer'] = $this->load->controller('common/column_footer');
		$data['newsletter'] = $this->load->controller('extension/module/newsletters');

		return $this->load->view('common/footer', $data);
	}
}
