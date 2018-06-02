<?php
class ControllerExtensionModuleAccount extends Controller {
	public function index() {
		$this->load->language('extension/module/account');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_newsletter'] = $this->language->get('text_newsletter');
		$data['text_recurring'] = $this->language->get('text_recurring');

		$data['logged'] = $this->customer->isLogged();
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['forgotten'] = $this->url->link('account/forgotten', '', true);
		$data['account'] = $this->url->link('account/account', '', true);
		$data['edit'] = $this->url->link('account/edit', '', true);
		$data['password'] = $this->url->link('account/password', '', true);
		$data['address'] = $this->url->link('account/address', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist');
		$data['order'] = $this->url->link('account/order', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['reward'] = $this->url->link('account/reward', '', true);
		$data['return'] = $this->url->link('account/return', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);
		$data['recurring'] = $this->url->link('account/recurring', '', true);
        
        
        $data['register_selected'] = false;
        if (($this->request->get['route'] == 'account/register') || ($this->request->get['route'] == 'account/simpleregister')) {
            $data['register_selected'] = true;
        }
        $data['login_selected'] = false;
        if ($this->request->get['route'] == 'account/login') {
            $data['login_selected'] = true;
        }
        $data['logout_selected'] = false;
        if ($this->request->get['route'] == 'account/logout') {
            $data['logout_selected'] = true;
        }
        $data['forgotten_selected'] = false;
        if ($this->request->get['route'] == 'account/forgotten') {
            $data['forgotten_selected'] = true;
        }
        $data['account_selected'] = false;
        if ($this->request->get['route'] == 'account/account') {
            $data['account_selected'] = true;
        }
        $data['edit_selected'] = false;
        if (($this->request->get['route'] == 'account/edit') || ($this->request->get['route'] == 'account/simpleedit')) {
            $data['edit_selected'] = true;
        }
        $data['password_selected'] = false;
        if ($this->request->get['route'] == 'account/password') {
            $data['password_selected'] = true;
        }
        $data['address_selected'] = false;
        if (($this->request->get['route'] == 'account/address') || ($this->request->get['route'] == 'account/simpleaddress/update') || ($this->request->get['route'] == 'account/simpleaddress/info') || ($this->request->get['route'] == 'account/simpleaddress/insert') || ($this->request->get['route'] == 'account/address/info') || ($this->request->get['route'] == 'account/address/update') || ($this->request->get['route'] == 'account/address/insert')) {
            $data['address_selected'] = true;
        }
        $data['wishlist_selected'] = false;
        if ($this->request->get['route'] == 'account/wishlist') {
            $data['wishlist_selected'] = true;
        }
        $data['order_selected'] = false;
        if (($this->request->get['route'] == 'account/order') || ($this->request->get['route'] == 'account/order/info')) {
            $data['order_selected'] = true;
        }
        $data['download_selected'] = false;
        if ($this->request->get['route'] == 'account/download') {
            $data['download_selected'] = true;
        }
        $data['reward_selected'] = false;
        if ($this->request->get['route'] == 'account/reward') {
            $data['reward_selected'] = true;
        }
        $data['transaction_selected'] = false;
        if ($this->request->get['route'] == 'account/transaction') {
            $data['transaction_selected'] = true;
        }
        $data['return_selected'] = false;
        if (($this->request->get['route'] == 'account/return') || ($this->request->get['route'] == 'account/return/info') || ($this->request->get['route'] == 'account/return/update') || ($this->request->get['route'] == 'account/return/insert')) {
            $data['return_selected'] = true;
        }
        $data['newsletter_selected'] = false;
        if ($this->request->get['route'] == 'account/newsletter') {
            $data['newsletter_selected'] = true;
        }



		return $this->load->view('extension/module/account', $data);
	}
}