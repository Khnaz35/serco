<?php
class ControllerCommonBreadcrumbs extends Controller {
    public function index()
    {
        $data['breadcrumbs'] = $this->document->getBreadcrumbs();
        return $this->load->view('common/breadcrumbs', $data);
    }
}