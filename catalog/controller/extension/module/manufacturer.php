<?php
class ControllerExtensionModuleManufacturer extends Controller

	{
	public

	function index()
		{
		$this->load->language('extension/module/manufacturer');
		$data['heading_title'] = $this->language->get('heading_title');
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/product');
		$data['categories'] = array();
		$data['manufacturers'] = array();
		$manufacturers = $this->model_catalog_manufacturer->getManufacturers();

		// echo "<pre>";
		// print_r($manufacturers);
		// echo "</pre>";

		if ($this->config->get('manufacturer_heading') != '')
			{
			$data['manufacturer_heading'] = $this->config->get('manufacturer_heading');
			}
		  else
			{
			$data['manufacturer_heading'] = 'Manufacturers';
			}

		if ($this->config->get('manufacturer_image_status') != '')
			{
			$data['manufacturer_image_status'] = $this->config->get('manufacturer_image_status');
			}
		  else
			{
			$data['manufacturer_image_status'] = 0;
			}

		if ($this->config->get('manufacturer_image_width') != '')
			{
			$data['manufacturer_image_width'] = $this->config->get('manufacturer_image_width');
			}
		  else
			{
			$data['manufacturer_image_width'] = 30;
			}

		if ($this->config->get('manufacturer_image_height') != '')
			{
			$data['manufacturer_image_height'] = $this->config->get('manufacturer_image_height');
			}
		  else
			{
			$data['manufacturer_image_height'] = 30;
			}

		foreach($manufacturers as $manufacturer)
			{
			$filter_data1 = array(
				'filter_manufacturer_id' => $manufacturer['manufacturer_id'],
			);
			$data['manufacturers'][] = array(
				'manufacturer_id' => $manufacturer['manufacturer_id'],
				'name' => $manufacturer['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data1) . ')' : '') ,
				'image' => $manufacturer['image'] ? 'image/' . $manufacturer['image'] : 'image/no_image.png',
				'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id'])
			);
			}

		return $this->load->view('extension/module/manufacturer', $data);
		}
	}

