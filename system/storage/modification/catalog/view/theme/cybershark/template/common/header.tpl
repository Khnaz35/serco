<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?></title>
    <base href="<?php echo $base; ?>" />
	<?php if ($robots) { ?>
		<meta name="robots" content="<?php echo $robots; ?>" />
	<?php } ?>
    <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
        <meta name="keywords" content= "<?php echo $keywords; ?>" />
    <?php } ?>
    <meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="<?php echo $og_url; ?>" />
    <?php if ($og_image) { ?>
        <meta property="og:image" content="<?php echo $og_image; ?>" />
    <?php } else { ?>
        <meta property="og:image" content="<?php echo $logo; ?>" />
    <?php } ?>
    <meta property="og:site_name" content="<?php echo $name; ?>" />
    <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    
    <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="catalog/view/javascript/jquery/scrollbar/jquery.scrollbar.css" rel="stylesheet" type="text/css" />
	<link href="catalog/view/javascript/mobile_menu/mobile_menu.css" rel="stylesheet" type="text/css" />
    <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <link href="catalog/view/theme/cybershark/stylesheet/stylesheet.css?ver=2" rel="stylesheet" type="text/css" />
    
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="catalog/view/javascript/jquery/scrollbar/jquery.scrollbar.min.js" type="text/javascript"></script>
	<script src="catalog/view/javascript/mobile_menu/mobile_menu.js" type="text/javascript"></script>
    <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js" type="text/javascript"></script>
    <link media="screen" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" type="text/css" rel="stylesheet" />
    <script src="catalog/view/javascript/getprice.js" type="text/javascript"></script>	
	<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js" type="text/javascript"></script>
	<link media="screen" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" type="text/css" rel="stylesheet">
	<script src="catalog/view/javascript/getcatalog.js" type="text/javascript"></script>	
    <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
    
    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>

<?php if($design_fastorder){ ?>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/fastorder<?php echo $design_fastorder;?>.css" />
<?php } else { ?>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/fastorder1.css" />
<?php } ?>
<script src="catalog/view/javascript/newfastorder.js" type="text/javascript"></script>	
<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js" type="text/javascript"></script>
<link media="screen" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" type="text/css" rel="stylesheet">	
<?php /*<script type="text/javascript" src="catalog/view/javascript/quickorder/owl-carousel/owl.carousel.min.js"></script> 
<link media="screen" href="catalog/view/javascript/quickorder/owl-carousel/owl.carousel.css" rel="stylesheet">*/ ?>
<script type="text/javascript">
function fastorder_open(product_id) {  
    $.magnificPopup.open({
        tLoading: '<span><i style="font-size:50px;" class="fa fa-spinner fa-pulse"></i></span>',
        items: {
        src: 'index.php?route=extension/module/newfastorder&product_id='+product_id,
        type: 'ajax'
		}
    });
}
function fastorder_open_cart() {  
    $.magnificPopup.open({
        tLoading: '<span><i style="font-size:50px;" class="fa fa-spinner fa-pulse"></i></span>',
        items: {
        src: 'index.php?route=extension/module/newfastordercart',
        type: 'ajax'
        }	
    });
}		
</script>

<style>
.btn-quick-order {
	background:#<?php echo $background_button_open_form_send_order;?>;
	border-color:#<?php echo $background_button_open_form_send_order;?>;
	color:#<?php echo $color_button_open_form_send_order;?> !important;
}
.btn-quick-order:hover {
	background:#<?php echo $background_button_open_form_send_order_hover;?>;
	border-color:#<?php echo $background_button_open_form_send_order_hover;?>;				
}
.fast-checkout .btn-ordercart {
	background:#<?php echo $background_button_open_form_send_order;?>;
	border-color:#<?php echo $background_button_open_form_send_order;?>;
	color:#<?php echo $color_button_open_form_send_order;?> !important;
}
.fast-checkout .btn-ordercart:hover {
	background:#<?php echo $background_button_open_form_send_order_hover;?>;
	border-color:#<?php echo $background_button_open_form_send_order_hover;?>;	
}
</style>
		
</head>

<body class="<?php echo $class; ?>">
	<script type="text/javascript">
              var button_shopping = "<?php echo $button_shopping; ?>";
              
              var button_checkout = "<?php echo $button_checkout; ?>";
              var link_checkout = "<?php echo $checkout; ?>";
              
              var button_compare = "<?php echo $button_compare; ?>";
              var link_compare = "<?php echo $compare; ?>";
              
              var button_wishlist = "<?php echo $button_wishlist; ?>";
              var link_wishlist = "<?php echo $wishlist; ?>";
            </script>
	<div id="header-fixed-header">
		<div class="container">
			<div class="row">

				<div class="hidden-xs col-sm-3 col-md-2 col-lg-2">
					<div class="header-float-logo">
						<?php if ($logo) { ?>
							<?php if ($home == $og_url) { ?>
								<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
							<?php } else { ?>
								<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
							<?php } ?>
						<?php } ?>
					</div>
				</div>

				<div class="col-xs-5 col-sm-3 col-md-6 col-lg-6">
					<?php if ($categories) { ?>
						<div id="header-menu-fixed">
							<div class="mobile-menu-fixed-toggle">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</div>
							<div class="menu-container">
								<ul class="list-unstyled">
									<?php foreach ($categories as $category) { ?>
										<li>
											<?php if ($category['children']) { ?>
												<a class="has-sub-child <?php if ($category['column'] == 100) { ?>extra-menu-item<?php } ?>" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?> <span></span></a>
												<div class="sub-child-container">
													<ul class="list-unstyled">
														<?php foreach ($category['children'] as $child) { ?>
															<li>
																<a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
																<?php if ($child['children']) { ?>
																	<div class="sub-sub-child-container">
																		<ul class="list-unstyled">
																			<?php foreach ($child['children'] as $subchild) { ?>
																				<li>
																					<a href="<?php echo $subchild['href']; ?>"><?php echo $subchild['name']; ?></a>
																				</li>
																			<?php } ?>
																		</ul>
																	</div>
																<?php } ?>
															</li>
														<?php } ?>
													</ul>
												</div>
											<?php } else { ?>
												<a class="<?php if ($category['column'] == 100) { ?>extra-menu-item<?php } ?>" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
											<?php } ?>
										</li>
									<?php } ?>
								</ul>

								<div class="clearfix">
								</div>
							</div>
						</div>
					<?php } ?>
				</div>


				<div class="col-xs-2 col-sm-1 col-md-1 col-lg-1">
					<div class="search-btn-fixed-container">
						<span class="search-fixed-toggle">
							<img src="/catalog/view/theme/cybershark/image/cotti/icon_search.png" />
						</span>
						<div class="header-search-fixed-container">
							<?php echo $search_fixed; ?>
						</div>
					</div>
					<div class="mobile-search-fixed">
						<a href="<?php echo $search_link; ?>"><img src="/catalog/view/theme/cybershark/image/cotti/icon_search.png" /></a>
					</div>
				</div>

				<div class="col-xs-2 col-sm-3 col-md-2 col-lg-2">
					<div class="header-callback_fixed-container">
						<a href="#callback" id="header-callback_fixed-btn"><?php echo $text_callback; ?></a>
					</div>
				</div>

				<div class="col-xs-3 col-sm-1 col-md-1 col-lg-1">
					<div class="header-cart_fixed-container">
						<?php echo $cart_fixed; ?>
					</div>
				</div>


			</div>
		</div>
	</div>

    <div id="header-container">
    
        <div id="header-top-menu">
            <div class="container">
                <div class="row">
                    <div class="col-xs-2 col-sm-8 col-md-9 col-lg-10">
                        <div class="header-top-pages-menu">
                            <?php if ($top_pages) { ?>
                                <div class="header-top-pages-menu-switcher">
                                    <i class="fa fa-bars" aria-hidden="true"></i>
                                </div>
                                <ul class="list-unstyled">
                                    <?php foreach ($top_pages as $top_page) { ?>
                                        <li  tabindex="0" >
                                            <a href="<?php echo $top_page['href']; ?>"><?php echo $top_page['name']; ?></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="col-xs-10 col-sm-4 col-md-3 col-lg-2">
                        
                        <div class="header-top-login-menu">
                            <?php if ($login_menu) { ?>
                                <ul class="list-unstyled">
                                    <?php foreach ($login_menu as $item) { ?>
                                        <li tabindex="0">
                                            <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                        </div>
                        
                        <div class="header-currency">
                            <?php echo $currency; ?>
                        </div>
                        
                        <div class="clearfix">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="container">
            <header>
                <div class="row">
                    
                    <div class="col-xs-12 col-sm-12 hidden-md hidden-lg">
                        <div class="header-logo-container">
                            <?php if ($logo) { ?>
                                <?php if ($home == $og_url) { ?>
                                    <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
                                
                                    <div class="header-logo-title">
                                        <?php echo $text_logo; ?>
                                    </div>
                                <?php } else { ?>
                                    <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                                
                                    <div class="header-logo-title">
                                        <a href="<?php echo $home; ?>"><?php echo $text_logo; ?></a>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>
                
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="header-working-time-container">
                            <i class="fa fa-clock-o" aria-hidden="true"></i> <?php echo $text_workingtime; ?> 
                            <div><?php echo $open; ?></div>
                        </div>
                        <div class="header-shops-container">
                            <ul class="list-unstyled">
                                <li>
                                    <a target="_blank" class="header-shops" href="<?php echo $shops_link; ?>"><i class="fa fa-map-marker" aria-hidden="true"></i> <span><?php echo $shops_text; ?></span></a>
                                </li>
                                <li>
                                    <a target="_blank" class="header-tailoring" href="<?php echo $tailoring_link; ?>"><span><?php echo $tailoring_text; ?></span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="hidden-xs hidden-sm col-md-4 col-lg-6">
                        <div class="header-logo-container">
                            <?php if ($logo) { ?>
                                <?php if ($home == $og_url) { ?>
                                    <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
                                
                                    <div class="header-logo-title">
                                        <?php echo $text_logo; ?>
                                    </div>
                                <?php } else { ?>
                                    <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                                
                                    <div class="header-logo-title">
                                        <a href="<?php echo $home; ?>"><?php echo $text_logo; ?></a>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>
                    
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="row">
                            <div class="col-xs-12 col-sm-9 col-md-9 col-lg-8">
                                <div class="header-phone-container">
                                    <?php echo $telephone; ?>
                                </div>
                                <div class="header-callback-container">
                                    <a href="#callback" id="header-callback-btn" class="b24-web-form-popup-btn-10"  ><?php echo $text_callback; ?></a>
                                </div>
                            </div>
                            
                            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-4">
                                <div class="header-cart-container">
                                    <?php echo $cart; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </header>
            
            <div id="header">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div id="header-menu" class="new">
                            <?php if ($categories) { ?>
                                <div class="mobile-menu-toggle">
                                    <i class="fa fa-bars" aria-hidden="true"></i>
                                    
                                    
                                    
                                    
                                     
                                    
                                    <div class="clearfix">
                                    </div>
                                </div>
                                <div class="menu-container">
                                    <ul class="list-unstyled">
                                        <?php foreach ($categories as $category) { ?>
                                            <li tabindex="0">
                                                <?php if ($category['children']) { ?>
                                             <!--     <a class="has-sub-child <?php if ($category['column'] == 100) { ?>extra-menu-item<?php } ?>" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?> <span></span></a> -->
                                                   
                                                    <a class="has-sub-child <?php if ($category['column'] == 100) { ?>extra-menu-item<?php } ?>" ><?php echo $category['name']; ?> <span></span></a>
                                                   
                                                    <div class="sub-child-container">
                                                        <ul class="list-unstyled">
                                                            <?php foreach ($category['children'] as $child) { ?>
                                                                <li>
                                                                    <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                                                    <?php if ($child['children']) { ?>
                                                                        <div class="sub-sub-child-container">
                                                                            <ul class="list-unstyled">
                                                                                <?php foreach ($child['children'] as $subchild) { ?>
                                                                                    <li>
                                                                                        <a href="<?php echo $subchild['href']; ?>"><?php echo $subchild['name']; ?></a>
                                                                                    </li>
                                                                                <?php } ?>
                                                                            </ul>
                                                                        </div>
                                                                    <?php } ?>
                                                                </li>
                                                            <?php } ?>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                <?php } else { ?>
                                                    <a class="<?php if ($category['column'] == 100) { ?>extra-menu-item<?php } ?>" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                                <?php } ?>
                                            </li>
                                            
                                          
                                            
                                            
                                            
                                        <?php } ?>
                                    </ul>
                                    
                                 
                                    
                                    <div class="clearfix">
                                    </div>
                                </div>
                            <?php } ?>
							 <div class="header-search-container">
								<?php echo $search; ?>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>