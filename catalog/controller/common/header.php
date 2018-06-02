<?php
class ControllerCommonHeader extends Controller {
    public function index() {
//start
        //$data['search_fixed'] = $this->load->controller('common/search_fixed');
        //$data['cart_fixed'] = $this->load->controller('common/cart_fixed');
//end
        // Analytics
        $this->load->model('extension/extension');

        $data['analytics'] = array();

        $analytics = $this->model_extension_extension->getExtensions('analytics');

        foreach ($analytics as $analytic) {
            if ($this->config->get($analytic['code'] . '_status')) {
                $data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
            }
        }

        $server = $this->config->get('config_url');

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        }

        if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
            $this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
        }

        $data['title'] = $this->document->getTitle();

        $data['base']        = $server;
        $data['description'] = $this->document->getDescription();
        $data['keywords']    = $this->document->getKeywords();
        $data['links']       = $this->document->getLinks();
        $data['robots']      = $this->document->getRobots();
        $data['styles']      = $this->document->getStyles();
        $data['scripts']     = $this->document->getScripts();
        $data['lang']        = $this->language->get('code');
        $data['direction']   = $this->language->get('direction');

        $data['logo'] = '';

        if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
            $data['logo'] = $server . 'image/' . $this->config->get('config_logo');
        }

        $this->load->language('common/header');
//start
        //XML
        $data['quicksignup'] = $this->load->controller('common/quicksignup');
//end
        $data['og_url']   = $server . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
        $data['og_image'] = $this->document->getOgImage();

        $data['signin_or_register'] = $this->language->get('signin_or_register');
        $data['text_home']          = $this->language->get('text_home');
        $data['text_get_catalog']   = $this->language->get('text_get_catalog');
//end
// Login menu

        $data['login_menu'] = array();

        // start: OCdevWizard SMWWL
        $this->load->model('ocdevwizard/ocdevwizard_setting');
        $smwwl_form_data = $this->model_ocdevwizard_ocdevwizard_setting->getSettingData('smart_wishlist_without_login_form_data');
        $smwwl_status = 0;

        if (isset($smwwl_form_data['activate']) && $smwwl_form_data['activate']) {
          $smwwl_status = 1;
        }
        // end: OCdevWizard SMWWL

        // Wishlist
        if ($this->customer->isLogged() || $smwwl_status) {
            $this->load->model('account/wishlist');

            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
            $data['login_menu'][] = array(
                'name' => $this->language->get('text_account'),
                'href'  => $this->url->link('account/account', '', true)
            );
            $data['login_menu'][] = array(
                'name' => $this->language->get('text_logout'),
                'href'  => $this->url->link('account/logout', '', true)
            );
        } else {
            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
            $data['login_menu'][] = array(
                'name' => $this->language->get('text_login'),
                'href'  => $this->url->link('account/login', '', true)
            );
            $data['login_menu'][] = array(
                'name' => $this->language->get('text_register'),
                'href'  => $this->url->link('account/register', '', true)
            );
        }

        //$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

        //$data['text_account'] = $this->language->get('text_account');
        //$data['text_register'] = $this->language->get('text_register');
        //$data['text_login'] = $this->language->get('text_login');
        //$data['text_order'] = $this->language->get('text_order');
        //$data['text_transaction'] = $this->language->get('text_transaction');
        //$data['text_download'] = $this->language->get('text_download');
        //$data['text_logout'] = $this->language->get('text_logout');
        $data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
        $data['text_page']          = $this->language->get('text_page');
        $data['text_checkout']      = $this->language->get('text_checkout');
        $data['text_callback']      = $this->language->get('text_callback');
        $data['text_contact']       = $this->language->get('text_contact');
        $data['text_logo']          = $this->language->get('text_logo');
        $data['text_workingtime']   = $this->language->get('text_workingtime');

        //$data['logged'] = $this->customer->isLogged();
        //$data['account'] = $this->url->link('account/account', '', true);
        //$data['register'] = $this->url->link('account/register', '', true);
        //$data['login'] = $this->url->link('account/login', '', true);
        //$data['order'] = $this->url->link('account/order', '', true);
        //$data['transaction'] = $this->url->link('account/transaction', '', true);
        //$data['download'] = $this->url->link('account/download', '', true);
        //$data['logout'] = $this->url->link('account/logout', '', true);
        $data['home']             = $this->url->link('common/home');
        $data['wishlist']         = $this->url->link('account/wishlist', '', true);
        $data['shopping_cart']    = $this->url->link('checkout/cart');
        $data['checkout']         = $this->url->link('checkout/checkout', '', true);
        $data['contact']          = $this->url->link('information/contact');
        $data['search_link']      = $this->url->link('product/search');

        $data['telephone'] = nl2br($this->config->get('config_telephone'));
        $data['fax']       = nl2br($this->config->get('config_fax'));
        $data['open']      = $this->config->get('config_open');
        $data['name']      = $this->config->get('config_name');

        $data['cart_total_items'] = $this->cart->countProducts();

        // Main menu

        $this->load->model('catalog/category');
        $this->load->model('design/banner');

        $data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        if ($categories) {
			$this->load->model('tool/image');
            foreach ($categories as $category) {
                if ($category['top']) {
                    // Level 2
                    $link_class = '';
                    $children_data = array();
                    $children = $this->model_catalog_category->getCategories($category['category_id']);
                    foreach ($children as $child) {
                        if ($child['top']) {
                            // Level 3
                            $link_class = ' dropdown';
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

                    $cat_banners = array();

                    if($category['banner_id']){
                        $banners = $this->model_design_banner->getBanner($category['banner_id']);

                        foreach ($banners as $banner) {
                            if (is_file(DIR_IMAGE . $banner['image'])) {
                                $image = $this->model_tool_image->resize($banner['image'], 640, 480);

                                $cat_banners[] = array(
                                    'title' => $banner['title'],
                                    'link'  => $banner['link'],
                                    'image' => $image
                                );
                            }
                        }
                    }

                    $column =  $category['column'] ? $category['column'] : 1;

                    // Level 1
                    if ($category['category_id'] == 102) {
                        $link_class .= ' header-sale';
                        $column = 100;
                    }

                    $total_items = count($children_data) + count($cat_banners);

                    $data['categories'][] = array(
                        'sub_menu_class' => 'total-children-' . $total_items,
                        'link_class'     => $link_class,
                        'banners'        => $cat_banners,
                        'name'           => $category['name'],
                        'children'       => $children_data,
                        'column'         => $column,
                        'href'           => $this->url->link('product/category', 'path=' . $category['category_id'])
                    );
                }
            }
        }
        /*$data['categories'][] = array(
            'name' => $this->language->get('text_special'),
            'children' => false,
            'column'   => 100,
            'href'  => $this->url->link('product/special')
        );*/

        // Top menu

        $this->load->model('catalog/information');

        $data['top_pages'] = array();

        $information_id = 4;
        $temp_information = $this->model_catalog_information->getInformation($information_id);

        if ($temp_information) {
            $data['top_pages'][] = array(
                'name' => $temp_information['title'],
                'href' => $this->url->link('information/information', 'information_id=' . $information_id)
            );
        }

        $data['top_pages'][] = array(
            'name' => $this->language->get('text_contact'),
            'href' => $this->url->link('information/contact')
        );
/*
        $informations = $this->model_catalog_information->getInformations();

        if ($informations) {

            foreach ($informations as $information) {
                if ($information['information_id'] == 8) {

                    $this->load->model('newsblog/category');
                    $this->load->language('newsblog/category');


                    $articles_id = 2; // ай-ди статей

                    $articles_info = $this->model_newsblog_category->getCategory($articles_id);
                    if ($articles_info) {
                        $data['top_pages'][] = array(
                            'name' => $articles_info['name'],
                            'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $articles_id)
                        );
                    }


                    $news_id = 1; //  ай-ди новостей

                    $news_info = $this->model_newsblog_category->getCategory($news_id);
                    if ($news_info) {
                        $data['top_pages'][] = array(
                            'name' => $news_info['name'],
                            'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $news_id)
                        );
                    }

                }
                if ($information['bottom']) {
                    $data['top_pages'][] = array(
                        'name' => $information['title'],
                        'href'  => $this->url->link('information/information', 'information_id=' . $information['information_id'])
                    );
                }
            }
        }

        $information_id = 11;
        $temp_information = $this->model_catalog_information->getInformation($information_id);
        if ($temp_information) {
            $data['shops_text'] = $temp_information['title'];
            $data['shops_link'] = $this->url->link('information/information', 'information_id=' . $information_id);
        }

        $information_id = 12;
        $temp_information = $this->model_catalog_information->getInformation($information_id);
        if ($temp_information) {
            $data['tailoring_text'] = $temp_information['title'];
            $data['tailoring_link'] = $this->url->link('information/information', 'information_id=' . $information_id);
        }*/

        $data['language'] = $this->load->controller('common/language');
        $data['currency'] = $this->load->controller('common/currency');
        $data['search'] = $this->load->controller('common/search');
        $data['cart'] = $this->load->controller('common/cart');

        // For page specific css
        if (isset($this->request->get['route'])) {
            if (isset($this->request->get['product_id'])) {
                $class = '-' . $this->request->get['product_id'];
            } elseif (isset($this->request->get['path'])) {
                $class = '-' . $this->request->get['path'];
            } elseif (isset($this->request->get['manufacturer_id'])) {
                $class = '-' . $this->request->get['manufacturer_id'];
            } elseif (isset($this->request->get['information_id'])) {
                $class = '-' . $this->request->get['information_id'];
            } else {
                $class = '';
            }

            $data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
        } else {
            $data['class'] = 'common-home';
        }

        return $this->load->view('common/header', $data);
    }
}
