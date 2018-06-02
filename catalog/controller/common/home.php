<?php
class ControllerCommonHome extends Controller {
    public function index() {
        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }

        /*if (isset($this->request->post['config_benefit_block_show'])) {
            $data['config_benefit_block_show'] = $this->request->post['config_benefit_block_show'];
        } else {
            $data['config_benefit_block_show'] = $this->config->get('config_benefit_block_show');
        }

        //$data['text_benefits'] = $this->language->get('text_benefits');
        $data['text_benefits'] = 'НАШИ ПРЕИМУЩЕСТВА';

        if (is_file(DIR_IMAGE . $this->config->get('config_benefit_icon_1'))) {
            $data['benefit_icon_1'] = $server . 'image/' . $this->config->get('config_benefit_icon_1');
        } else {
            $data['benefit_icon_1'] = false;
        }
        if (is_file(DIR_IMAGE . $this->config->get('config_benefit_icon_2'))) {
            $data['benefit_icon_2'] = $server . 'image/' . $this->config->get('config_benefit_icon_2');
        } else {
            $data['benefit_icon_2'] = false;
        }
        if (is_file(DIR_IMAGE . $this->config->get('config_benefit_icon_3'))) {
            $data['benefit_icon_3'] = $server . 'image/' . $this->config->get('config_benefit_icon_3');
        } else {
            $data['benefit_icon_3'] = false;
        }
        if (is_file(DIR_IMAGE . $this->config->get('config_benefit_icon_4'))) {
            $data['benefit_icon_4'] = $server . 'image/' . $this->config->get('config_benefit_icon_4');
        } else {
            $data['benefit_icon_4'] = false;
        }*/

        //$this->load->model('localisation/language');

        if (isset($this->request->post['config_langdata'])) {
            $data['config_langdata'] = $this->request->post['config_langdata'];
        } else {
            $data['config_langdata'] = $this->config->get('config_langdata');
        }
        //var_dump($data['config_langdata']);

        //$front_language_id = $this->config->get('config_language_id');

        /*$data['benefit_icons'][1]['image'] = $data['benefit_icon_1'];
        $data['benefit_icons'][1]['title'] = html_entity_decode($data['config_langdata'][$front_language_id]['benefit_title_1'], ENT_QUOTES, 'UTF-8');

        $data['benefit_icons'][2]['image'] = $data['benefit_icon_2'];
        $data['benefit_icons'][2]['title'] = html_entity_decode($data['config_langdata'][$front_language_id]['benefit_title_2'], ENT_QUOTES, 'UTF-8');

        $data['benefit_icons'][3]['image'] = $data['benefit_icon_3'];
        $data['benefit_icons'][3]['title'] = html_entity_decode($data['config_langdata'][$front_language_id]['benefit_title_3'], ENT_QUOTES, 'UTF-8');

        $data['benefit_icons'][4]['image'] = $data['benefit_icon_4'];
        $data['benefit_icons'][4]['title'] = html_entity_decode($data['config_langdata'][$front_language_id]['benefit_title_4'], ENT_QUOTES, 'UTF-8');*/


        $this->document->setTitle($this->config->get('config_meta_title'));
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));

        if (isset($this->request->get['route'])) {
            $this->document->addLink($this->config->get('config_url'), 'canonical');
        }

        $data['column_baner1'] = $this->load->controller('common/column_baner1');
        $data['column_baner2'] = $this->load->controller('common/column_baner2');
        $data['column_baner3'] = $this->load->controller('common/column_baner3');
        $data['column_center'] = $this->load->controller('common/column_center');

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        //$data['galery_diplom'] = $this->load->controller('information/galery_diplom');
        $this->response->setOutput($this->load->view('common/home', $data));
    }
}
