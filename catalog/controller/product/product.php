<?php
class ControllerProductProduct extends Controller {
    private $error = array();

    public function index() {
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/css/theme.min.css');
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/css/star-rating.min.css');
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/css/swiper.min.css');
        $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/swiper.min.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/jquery.zoom.min.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/theme.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/locales/LANG.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/star-rating.min.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/InputSpinner.js');
        $this->document->addScript('catalog/view/theme/' . $this->config->get('config_theme') . '/assets/js/sticky-kit.min.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
        $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');

        $base = (($this->request->server['HTTPS']) ? $this->config->get('config_ssl') : $this->config->get('config_url'));
        $base_image = $base . 'image/';

        $get_params = array();
        $get_params['default'] = array('sort', 'order', 'page', 'limit');
        $get_params['search']  = array('search', 'tag', 'description', 'category_id', 'sub_category');
        $get_params['product'] = array('path', 'filter', 'manufacturer_id');

        $url = '';

        foreach ($get_params['default'] as $value) {
            if(isset($this->request->get[$value])){
                $url .= '&' . $value . '=' . $this->request->get[$value];
            }
        }

        $search_url = $url;

        foreach ($get_params['search'] as $value) {
            if(isset($this->request->get[$value])){
                $search_url .= '&' . $value . '=' . $this->request->get[$value];
            }
        }

        $full_url = $search_url;

        foreach ($get_params['product'] as $value) {
            if(isset($this->request->get[$value])){
                $full_url .= '&' . $value . '=' . $this->request->get[$value];
            }
        }


        $this->load->language('product/product');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );


        $this->load->model('catalog/category');

        $category_info = '';

        if (isset($this->request->get['path'])) {
            $path = '';
            $parts = explode('_', (string)$this->request->get['path']);
            $category_id = (int)array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
                );
            }
        }

        $this->load->model('catalog/manufacturer');
        $manufacturer_info = '';

        if (isset($this->request->get['manufacturer_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_brand'),
                'href' => $this->url->link('product/manufacturer')
            );

            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

            if ($manufacturer_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $manufacturer_info['name'],
                    'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
                );
            }
        }

        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('product/search', $search_url)
            );
        }

        $product_id = 0;

        if (isset($this->request->get['product_id'])) {
            $product_id = (int)$this->request->get['product_id'];
        }

        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            $data['breadcrumbs'][] = array(
                'text' => $product_info['name'],
                'href' => $this->url->link('product/product', $full_url . '&product_id=' . $product_id)
            );

            $meta_title = $product_info['name'];

            if ($product_info['meta_title']) {
                $meta_title = $product_info['meta_title'];
            }

            $this->document->setTitle($meta_title);
            $this->document->setDescription($product_info['meta_description']);
            $this->document->setKeywords($product_info['meta_keyword']);

            $data['heading_title'] = $product_info['name'];

            if ($product_info['meta_h1']) {
                $data['heading_title'] = $product_info['meta_h1'];
            }

            $data['text_select']             = $this->language->get('text_select');
            $data['text_manufacturer']       = $this->language->get('text_manufacturer');
            $data['text_model']              = $this->language->get('text_model');
            $data['text_sku']                = $this->language->get('text_sku');
            $data['text_reward']             = $this->language->get('text_reward');
            $data['text_points']             = $this->language->get('text_points');
            $data['text_stock']              = $this->language->get('text_stock');
            $data['text_discount']           = $this->language->get('text_discount');
            $data['text_tax']                = $this->language->get('text_tax');
            $data['text_option']             = $this->language->get('text_option');
            $data['text_minimum']            = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_write']              = $this->language->get('text_write');
            $data['text_login']              = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
            $data['text_note']               = $this->language->get('text_note');
            $data['text_tags']               = $this->language->get('text_tags');
            $data['text_related']            = $this->language->get('text_related');
            $data['text_payment_recurring']  = $this->language->get('text_payment_recurring');
            $data['text_loading']            = $this->language->get('text_loading');

            $data['entry_qty']               = $this->language->get('entry_qty');
            $data['entry_name']              = $this->language->get('entry_name');
            $data['entry_review']            = $this->language->get('entry_review');
            $data['entry_rating']            = $this->language->get('entry_rating');
            $data['entry_good']              = $this->language->get('entry_good');
            $data['entry_bad']               = $this->language->get('entry_bad');

            $data['button_cart']             = $this->language->get('button_cart');
            //start
            $data['text_bestseller']         = $this->language->get('text_bestseller');
            $data['text_special']            = $this->language->get('text_special');
            $data['text_latest']             = $this->language->get('text_latest');
            $data['text_share']              = $this->language->get('text_share');
            $data['text_dimentions_table']   = $this->language->get('text_dimentions_table');
            $data['text_rozn']               = $this->language->get('text_rozn');
            $data['text_mopt']               = $this->language->get('text_mopt');
            $data['text_opt']                = $this->language->get('text_opt');
            $data['text_known']              = $this->language->get('text_known');
            $data['text_known_opt']          = $this->language->get('text_known_opt');
            $data['text_more']               = $this->language->get('text_more');
            $data['text_color_stock_status'] = $this->language->get('text_color_stock_status');
            $data['text_colors']             = $this->language->get('text_colors');
            // end
            $data['button_wishlist']         = $this->language->get('button_wishlist');
            $data['button_compare']          = $this->language->get('button_compare');
            $data['button_upload']           = $this->language->get('button_upload');
            $data['button_continue']         = $this->language->get('button_continue');
            $data['button_preorder']         = $this->language->get('button_preorder');

            $data['tab_description']         = $this->language->get('tab_description');
            $data['tab_attribute']           = $this->language->get('tab_attribute');
            $data['tab_review']              = sprintf($this->language->get('tab_review'), $product_info['reviews']);
            $data['tab_return']              = $this->language->get('tab_return');


            $data['product_id']    = (int)$product_id;
            $data['manufacturer']  = $product_info['manufacturer'];
            $data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $data['model']         = $product_info['model'];
            $data['sku']           = $product_info['sku'];
            $data['reward']        = $product_info['reward'];
            $data['points']        = $product_info['points'];
            $data['description']   = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

            $this->load->model('catalog/information');
            $this->load->model('catalog/review');
            $data['dimentions_table']       = $this->url->link('information/information/agree', 'information_id=16', true);

            if ($product_info['quantity'] <= 0) {
                $data['stock'] = $product_info['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $data['stock'] = $product_info['quantity'];
            } else {
                $data['stock'] = $this->language->get('text_instock');
            }
            $data['quantity'] = $product_info['quantity'];

            $this->load->model('tool/image');

            $data['images'] = array();
            $data['popup'] = $base_image . 'no_image.png';

            if ($product_info['image']) {
                $popup = $base_image . $product_info['image'];

                $data['popup'] = $popup;
                $data['images'][] = $popup;
            }

            $results = $this->model_catalog_product->getProductImages($product_id);

            foreach ($results as $result) {
                $data['images'][] = $base_image . $result['image'];
            }

            $data['price'] = false;

            if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            }

            $data['special'] = false;

            if ((float)$product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            }

//start
            if ((int)$this->config->get('config_customer_group_id') != 1) {
               $data['special'] = false;

               $product_rozn_price = $this->model_catalog_product->getProductRoznPrice($product_id);
                if ($product_rozn_price){
                   if ((float)$product_rozn_price) {
                       $data['price'] = $this->currency->format($this->tax->calculate($product_rozn_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                   }
                }
            }
// end
            $data['tax'] = false;

            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
            }

            $discounts = $this->model_catalog_product->getProductDiscounts($product_id);

            $data['discounts'] = array();

            foreach ($discounts as $discount) {
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
                );
            }

//start
            $data['colors'] = array();

            foreach ($this->model_catalog_product->getProductColors($product_id) as $color) {

                $color_selected = false;

                if ($color['color_image']) {
                    $color_image = $this->model_tool_image->resize($color['color_image'], 36, 36);
                } else {
                    $color_image = $this->model_tool_image->resize('placeholder.png', 36, 36);
                }

                if ($product_id == $color['product_id']) {
                    $color_selected = true;
                }

                $color_product_name = false;
                $color_product_image = false;
                $color_quantity = 0;

                $temp_color_product_data = array();

                $temp_color_product_data = $this->model_catalog_product->getProduct($color['product_id']);

                if ($temp_color_product_data) {
                    if ($temp_color_product_data['image']) {
                        $color_product_image = $this->model_tool_image->resize($temp_color_product_data['image'], 80, 80);
                    } else {
                        $color_product_image = $this->model_tool_image->resize('placeholder.png', 80, 80);
                    }
                    $color_product_name = $temp_color_product_data['name'];
                    $color_quantity = $temp_color_product_data['quantity'];
                }

                $data['colors'][] = array(
                    'product_id'        => $color['product_id'],
                    'product_name'      => $color_product_name,
                    'product_image'     => $color_product_image,
                    'link'              => $this->url->link('product/product', '&product_id=' . $color['product_id']),
                    'color_name'        => $color['color_name'],
                    'color_image'       => $color_image,
                    'quantity'          => $color_quantity,
                    'selected'          => $color_selected
                );

            }
//end
            $data['options'] = array();

            foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if ($option['type'] == 'radio') {
                        $price = false;

                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id'         => $option_value['option_value_id'],
                            'name'                    => $option_value['name'],
                            'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                            'price'                   => $price,
                            'price_prefix'            => $option_value['price_prefix'],
                            'quantity'                => $option_value['quantity']
                        );
                    } elseif (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        $price = false;

                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id'         => $option_value['option_value_id'],
                            'name'                    => $option_value['name'],
                            'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                            'price'                   => $price,
                            'price_prefix'            => $option_value['price_prefix'],
                            'quantity'                => $option_value['quantity']
                        );
                    }
                }

                $data['options'][] = array(
                    'product_option_id'    => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id'            => $option['option_id'],
                    'name'                 => $option['name'],
                    'type'                 => $option['type'],
                    'value'                => $option['value'],
                    'required'             => $option['required']
                );
            }

            $data['minimum'] = 1;

            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            }

            $data['review_status'] = $this->config->get('config_review_status');
            $data['review_guest'] = false;

            if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
                $data['review_guest'] = true;
            }

            $data['customer_name'] = '';

            if ($this->customer->isLogged()) {
                $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
            }

            $data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
            $data['rating'] = (int)$product_info['rating'];

            // Captcha
            $data['captcha'] = '';

            if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
                $data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
            }

            $data['share'] = $this->url->link('product/product', 'product_id=' . (int)$product_id);

            $data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($product_id);

            $data['products'] = array();

            $results = $this->model_catalog_product->getProductRelated($product_id);

            foreach ($results as $result) {
                $image_name = 'placeholder.png';

                if ($result['image']) {
                    $image_name = $result['image'];
                }

                $image = $this->model_tool_image->resize($image_name, $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));

                $price = false;

                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                }

                $special = false;
                $special_rate = 0;

                if ((float)$result['special']) {
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

                $labels = array();

                if ($result['jan'] == 1) {
                    $labels[] = array(
                        'class' => 'newness',
                        'text' => 'New'
                    );
                }
                if ($special_rate) {
                    $labels[] = array(
                        'class' => 'onsale',
                        'text' => $special_rate
                    );
                }
                if ($result['jan'] == 3) {
                    $labels[] = array(
                        'class' => 'featured',
                        'text' => 'hot'
                    );
                }

                $current_product_mopt_price = $this->model_catalog_product->getProductMOptPrice($result['product_id']);
                $current_mopt_price = false;
                if ($current_product_mopt_price){
                   if ((float)$current_product_mopt_price) {
                       $current_mopt_price = $this->currency->format($this->tax->calculate($current_product_mopt_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                   }
                }

                if ((int)$this->config->get('config_customer_group_id') != 1) {
                   $special = false;

                   $current_product_rozn_price = $this->model_catalog_product->getProductRoznPrice($result['product_id']);
                    if ($current_product_rozn_price){
                       if ((float)$current_product_rozn_price) {
                           $price = $this->currency->format($this->tax->calculate($current_product_rozn_price, $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                       }
                    }
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
                    if ($option['option_id'] == 14) {
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
                    'labels'       => $labels,
                    'mopt_price'  => $current_mopt_price,
                    'options'     => $product_options,
                    'thumb'       => $image,
                    'name'        => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                    'price'       => $price,
                    'special'     => $special,
                    'tax'         => $tax,
                    'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating'      => $rating,
                    'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $data['tags'] = array();

            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag'  => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $data['product_color'] = $this->model_catalog_product->getProductColor($product_id);

            $relative_colors = $this->model_catalog_product->getRelativeProductsColor($product_id);

            $data['relative_products_color'] = array();

            foreach ($relative_colors as $product_color)
            {
                $data['relative_products_color'][] = array(
                    'name'        => $product_color['name'],
                    'color_image' => $product_color['color_image'],
                    'link'        => $this->url->link('product/product', 'product_id=' . $product_id)
                );
            };

            $data['product_link']= $this->url->link('product/product', 'product_id=' . $product_id);

            $data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

            $this->model_catalog_product->updateViewed($this->request->get['product_id']);

            $this->document->setBreadcrumbs($data['breadcrumbs']);

            $data['tab_guarantee'] = '';

            $this->load->model('extension/module');
            $setting_info = $this->model_extension_module->getModule(48);

            if ($setting_info && $setting_info['status']) {
            	$output = $this->load->controller('extension/module/html', $setting_info);

            	if ($output) {
            		$data['tab_guarantee'] = $output;
            	}
            }


            $data['breadcrumbs']    = $this->load->controller('common/breadcrumbs');

            $data['column_left']    = $this->load->controller('common/column_left');
            $data['column_right']   = $this->load->controller('common/column_right');
            $data['content_top']    = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer']         = $this->load->controller('common/footer');
            $data['header']         = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('product/product', $data));
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/product', $full_url . '&product_id=' . $product_id)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title']   = $this->language->get('text_error');
            $data['text_error']      = $this->language->get('text_error');
            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $this->document->setBreadcrumbs($data['breadcrumbs']);

            $data['breadcrumbs']    = $this->load->controller('common/breadcrumbs');

            $data['column_left']    = $this->load->controller('common/column_left');
            $data['column_right']   = $this->load->controller('common/column_right');
            $data['content_top']    = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer']         = $this->load->controller('common/footer');
            $data['header']         = $this->load->controller('common/header');

            $this->response->setOutput($this->load->view('error/not_found', $data));
        }
    }

    public function review() {
        $limit = 8;

        $this->load->language('product/product');

        $this->load->model('catalog/review');

        $data['text_no_reviews'] = $this->language->get('text_no_reviews');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['reviews'] = array();

        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

        $results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * $limit, $limit);

        foreach ($results as $result) {
            $data['reviews'][] = array(
                'author'     => $result['author'],
                'text'       => nl2br($result['text']),
                'rating'     => (int)$result['rating'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($review_total - $limit)) ? $review_total : ((($page - 1) * $limit) + $limit), $review_total, ceil($review_total / $limit));

        $this->response->setOutput($this->load->view('product/review', $data));
    }

    public function write() {
        $this->load->language('product/product');

        $json = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            if ((utf8_strlen($this->request->post['text']) < 1) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }

            // Captcha
            if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
                $captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

                if ($captcha) {
                    $json['error'] = $captcha;
                }
            }

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getRecurringDescription() {
        $this->load->language('product/product');
        $this->load->model('catalog/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        if (isset($this->request->post['recurring_id'])) {
            $recurring_id = $this->request->post['recurring_id'];
        } else {
            $recurring_id = 0;
        }

        if (isset($this->request->post['quantity'])) {
            $quantity = $this->request->post['quantity'];
        } else {
            $quantity = 1;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        $recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

        $json = array();

        if ($product_info && $recurring_info) {
            if (!$json) {
                $frequencies = array(
                    'day'        => $this->language->get('text_day'),
                    'week'       => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month'      => $this->language->get('text_month'),
                    'year'       => $this->language->get('text_year'),
                );

                if ($recurring_info['trial_status'] == 1) {
                    $price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                    $trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
                } else {
                    $trial_text = '';
                }

                $price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

                if ($recurring_info['duration']) {
                    $text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                } else {
                    $text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                }

                $json['success'] = $text;
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
