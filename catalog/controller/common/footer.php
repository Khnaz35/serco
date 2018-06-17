<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

        $data['scripts'] = $this->document->getScripts('footer');
        $data['home']    = $this->url->link('common/home');
        $data['contact'] = $this->url->link('information/contact');
        $data['og_url']  = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
        $data['powered'] = sprintf($this->language->get('text_powered'), date('Y', time()), $this->config->get('config_name'));


        $data['text_home']    = $this->language->get('text_home');
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

        $data['categories'] = array();

        $data['categories'][] = array(
            'style'          => '',
            'children'       => array(),
            'name'           => $this->language->get('text_home'),
            'href'           => $this->url->link('common/home')
        );

        $this->load->model('catalog/category');
        $categories = $this->model_catalog_category->getCategories(0);

        if ($categories) {
            foreach ($categories as $category) {
                if ($category['top']) {
                    // Level 2
                    $style = '';
                    $children_data = array();
                    $children = $this->model_catalog_category->getCategories($category['category_id']);

                    foreach ($children as $child) {
                        if ($child['top']) {
                            // Level 3
                            $sub_children_data = array();
                            $sub_children = $this->model_catalog_category->getCategories($child['category_id']);

                            foreach ($sub_children as $sub_child) {
                                if ($sub_child['top']) {
                                    $sub_children_data[] = array(
                                        'name'  => $sub_child['name'],
                                        'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $sub_child['category_id'])
                                    );
                                }
                            }

                            $children_data[] = array(
                                'name'     => $child['name'],
                                'children' => $sub_children_data,
                                'href'     => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
                            );
                        }
                    }

                    // Level 1
                    if ($category['category_id'] == 102) {
                        $style = 'color:red;';
                    }

                    $data['categories'][] = array(
                        'style'          => $style,
                        'name'           => $category['name'],
                        'children'       => $children_data,
                        'href'           => $this->url->link('product/category', 'path=' . $category['category_id'])
                    );
                }
            }
        }

        $data['categories'][] = array(
            'style'          => '',
            'children'       => array(),
            'name'           => $this->config->get('config_telephone'),
            'href'           => str_replace(array('(', ')', ' '), '', $this->config->get('config_telephone'))
        );

        $data['categories'][] = array(
            'style'          => '',
            'children'       => array(),
            'name'           => $this->config->get('config_fax'),
            'href'           => str_replace(array('(', ')', ' '), '', $this->config->get('config_fax'))
        );

        $data['categories'][] = array(
            'style'          => '',
            'children'       => array(),
            'name'           => $this->language->get('text_contact'),
            'href'           => $this->url->link('information/contact')
        );

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

            $ip = '';

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			}

            $url = '';

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			}

            $referer = '';

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

        $data['column_footer'] = $this->load->controller('common/column_footer');
		$data['newsletter'] = $this->load->controller('extension/module/newsletters');

		return $this->load->view('common/footer', $data);
	}
}
