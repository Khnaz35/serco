<?php
class ControllerProductLatest extends Controller {
    public function index() {
        $this->load->language('product/latest');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $data['breadcrumbs'] = array(
            array('text' => $this->language->get('text_home'),
                  'href' => $this->url->link('common/home')),
            array('text' => $this->language->get('heading_title'),
                  'href' => $this->url->link('product/latest'))
        );

        $language_keys = array('button_cart', 'button_wishlist', 'text_choose_size', 'heading_title');

        foreach ($language_keys as $key) {
            $data[$key] = $this->language->get($key);
        }

        $this->document->setTitle($this->language->get('meta_title'));
        $this->document->setDescription($this->language->get('meta_description'));
        $this->document->setKeywords($this->language->get('meta_keyword'));
        $this->document->setBreadcrumbs($data['breadcrumbs']);

        $page  = ((isset($this->request->get['page']))? $this->request->get['page'] : 1);
        $limit = $this->config->get($this->config->get('config_theme') . '_product_limit');

        $filter_data = array(
            'sort'  => 'p.date_added',
            'order' => 'DESC',
            'start' => ($page - 1) * $limit,
            'limit' => $limit
        );

        $data['products'] = array();

        $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
        $results       = $this->model_catalog_product->getProducts($filter_data);

        foreach ($results as $result) {
            $product_image = (($result['image'])? $result['image'] : 'placeholder.png');

            $image = $this->model_tool_image->resize($product_image, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));

            $price = false;

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            }

            $special_rate = 0;
            $special = false;

            if ((float)$result['special'] && (int)$this->config->get('config_customer_group_id') != 1) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                $special_rate = '-' . round(($result['price'] - $result['special']) / $result['price'] * 100, 0) . '%';
            }

            $tax = false;

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
            }

            $rating = false;

            if ($this->config->get('config_review_status')) {
                $rating = (int)$result['rating'];
            }

            $current_product_mopt_price = $this->model_catalog_product->getProductMOptPrice($result['product_id']);
            $current_mopt_price = false;

            if ($current_product_mopt_price){
               if ((float)$current_product_mopt_price) {
                   $current_mopt_price = $this->currency->format($this->tax->calculate($current_product_mopt_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
               }
            }

            if ((int)$this->config->get('config_customer_group_id') != 1) {
               $current_product_rozn_price = $this->model_catalog_product->getProductRoznPrice($result['product_id']);
                if ($current_product_rozn_price){
                   if ((float)$current_product_rozn_price) {
                       $price = $this->currency->format($this->tax->calculate($current_product_rozn_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                   }
                }
            }

            $labels = array();
            $labels[] = array('class' => 'newness','text' => 'New');

            if ($special_rate) {
                $labels[] = array('class' => 'onsale', 'text' => $special_rate);
            }

            if ($result['jan'] == 3) {
                $labels[] = array('class' => 'featured','text' => 'hot');
            }

            $product_options = array();

            foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if ($option['type'] == 'radio') {
                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id'         => $option_value['option_value_id'],
                            'name'                    => $option_value['name'],
                            'quantity'                => $option_value['quantity']
                        );
                    }
                }
                if ($option['option_id'] == 74) {
                    $product_options[] = array(
                        'product_option_id'    => $option['product_option_id'],
                        'product_option_value' => $product_option_value_data,
                        'option_id'            => $option['option_id'],
                        'name'                 => $option['name'],
                        'type'                 => $option['type'],
                        'value'                => $option['value'],
                        'required'             => $option['required']
                    );
                }
            }

            $data['products'][] = array(
                'product_id'  => $result['product_id'],
                //start
                'labels'      => $labels,
                'mopt_price'  => $current_mopt_price,
                'options'     => $product_options,
                //end
                'thumb'       => $image,
                'name'        => $result['name'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                'price'       => $price,
                'special'     => $special,
                'tax'         => $tax,
                'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
                'rating'      => $rating,
                'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
            );
        }

        $pagination        = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $page;
        $pagination->limit = $limit;
        $pagination->url   = $this->url->link('product/latest', '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

        // http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
        if ($page == 1) {
            $this->document->addLink($this->url->link('product/latest', '', true), 'canonical');
        } elseif ($page == 2) {
            $this->document->addLink($this->url->link('product/latest', '', true), 'prev');
        } else {
            $this->document->addLink($this->url->link('product/latest', 'page='. ($page - 1), true), 'prev');
        }

        if ($limit && ceil($product_total / $limit) > $page) {
            $this->document->addLink($this->url->link('product/latest', 'page='. ($page + 1), true), 'next');
        }

        $data['continue'] = $this->url->link('common/home');

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('product/latest', $data));
    }
}