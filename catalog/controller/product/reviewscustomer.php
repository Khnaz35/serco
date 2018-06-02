<?php
class ControllerProductReviewscustomer extends Controller {
    public function index() {
        $this->language->load('extension/module/reviewscustomer');

        $this->load->model('catalog/product');

        $this->load->model('catalog/reviewscustomer');

        $this->load->model('tool/image');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        //$limit = $this->config->get('config_product_limit') ? $this->config->get('config_product_limit') : 10;
        $limit = 20;

        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('product/reviewscustomer', $url),
            'separator' => $this->language->get('text_separator')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_empty'] = $this->language->get('text_empty');
		$data['text_review_about'] = $this->language->get('text_review_about');
        $data['reviews'] = array();

        $reviews_total = $this->model_catalog_reviewscustomer->getTotalCustomerReviews();

        $results = $this->model_catalog_reviewscustomer->getAllCustomerReviews(($page - 1) * $limit, $limit);

        foreach ($results as $result) {
            if ($this->config->get('config_review_status')) {
                $rating = $result['rating'];
            } else {
                $rating = false;
            }

            $product_id = false;
            $prod_thumb = false;
            $prod_name = false;
            $prod_model = false;
            $prod_href = false;

            if ($result['product_id']) {
                $product = $this->model_catalog_product->getProduct($result['product_id']);
      
				if ($product['image']) {
					if (VERSION >= 2.2) {
						$prod_thumb = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
					} else {
						$prod_thumb = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}
				}
                $product_id = $product['product_id'];
                $prod_name = $product['name'];
                $prod_model = $product['model'];
                $prod_href = $this->url->link('product/product', 'product_id=' . $product['product_id']);
            }

            $data['reviews'][] = array(
                'review_id'   => $result['review_id'],
                'rating'      => $rating,
                'text' => $result['text'],
                'date_added'  => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                'author'      => $result['author'],
                'prod_thumb'  => $prod_thumb,
                'prod_name'   => $prod_name,
                'prod_model'  => $prod_model,
                'prod_href'   => $prod_href,
                'prod_about'  => sprintf($this->language->get('text_review_about'), $prod_href, $prod_name)
			
            );
        }

        $pagination = new Pagination();
        $pagination->total = $reviews_total;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $this->url->link('product/reviewscustomer', '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($reviews_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($reviews_total - $limit)) ? $reviews_total : ((($page - 1) * $limit) + $limit), $reviews_total, ceil($reviews_total / $limit));

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
		if (VERSION >= 2.2) {
			$this->response->setOutput($this->load->view('product/reviewscustomer', $data));
		} else {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/reviewscustomer.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/reviewscustomer.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/product/reviewscustomer.tpl', $data));
			}
        }
    }
}