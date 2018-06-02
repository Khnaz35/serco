<?php
class ControllerExtensionModuleSlideshow extends Controller {
	public function index($setting) {
		static $module = 20000;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$this->document->addStyle('catalog/view/theme/sergio_cotti/assets/css/swiper.min.css');
		$this->document->addScript('catalog/view/theme/sergio_cotti/assets/js/swiper.min.js');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				if($setting['resize']){
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				}else{
					if ($this->request->server['HTTPS']) {
						$image = $this->config->get('config_ssl') . 'image/' . $result['image'];
					} else {
						$image = $this->config->get('config_url') . 'image/' . $result['image'];
					}
				}

				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $image
				);
			}
		}

		$data['module'] = $module++;
        
        if(!empty($setting['view']) && file_exists(DIR_TEMPLATE . $this->config->get('config_theme') . '/template/extension/module/slideshow_'. $setting['view'] . '.tpl')){
            return $this->load->view('extension/module/slideshow_' . $setting['view'] . '.tpl', $data);
        }else{
            return $this->load->view('extension/module/slideshow', $data);
        }
	}
}
