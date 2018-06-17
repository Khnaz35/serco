<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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

    <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <link href="catalog/view/theme/sergio_cotti/assets/css/fontawesome-all.min.css" rel="stylesheet">
    <link href="catalog/view/theme/sergio_cotti/assets/css/jquery.mmenu.all.css" rel="stylesheet">
    <link href="catalog/view/theme/sergio_cotti/assets/css/jquery-ui.min.css" rel="stylesheet">
    <link href="catalog/view/theme/sergio_cotti/assets/css/hamburgers.min.css" rel="stylesheet">

    <!-- build:css -->
    <link href="catalog/view/theme/sergio_cotti/assets/css/main.css" rel="stylesheet">
    <!-- endbuild -->


    <script src="catalog/view/theme/sergio_cotti/assets/js/jquery-3.3.1.min.js"></script>
    <script src="catalog/view/theme/sergio_cotti/assets/js/jquery-ui.min.js"></script>
    <script src="catalog/view/theme/sergio_cotti/assets/js/popper.min.js"></script>
    <script src="catalog/view/theme/sergio_cotti/assets/js/bootstrap.min.js"></script>
    <script src="catalog/view/theme/sergio_cotti/assets/js/jquery.matchHeight-min.js"></script>
    <script src="catalog/view/theme/sergio_cotti/assets/js/jquery.mmenu.all.js"></script>


    <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>

    <script src="catalog/view/javascript/common.js" type="text/javascript"></script>

    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
</head>

<body class="<?php echo $class; ?>">
    <!-- Wrapper for mobile menu -->
    <div id="wrapper">
        <!-- Top line header -->
        <div id="pre-header" class="d-none d-md-block">
            <div class="container-fluid clearfix">
                <div class="left-row float-left">
                    <ul class="list-unstyled">
                        <li><a href="#"><?php echo $telephone; ?></a>
                            <!-- <span class="phone-header">Анастасия</span> --></li>
                        <li><a href="#"><?php echo $fax; ?></a>
                            <!-- <span class="phone-header">Юлия</span> --></li>
                        <li class=""><a href="#callback"><?php echo $text_callback; ?></a></li>
                    </ul>
                </div>
                <div class="right-row float-right">
                    <ul class="list-unstyled">
                        <?php if ($top_pages) { ?>
                            <?php foreach ($top_pages as $top_page) { ?>
                                <li>
                                    <a href="<?php echo $top_page['href']; ?>"><?php echo $top_page['name']; ?></a>
                                </li>
                            <?php } ?>
                        <?php } ?>
                        <?php if ($login_menu) { ?>
                            <?php foreach ($login_menu as $item) { ?>
                                <li>
                                    <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                                </li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
            </div>
        </div>
        <!-- Top line header end-->

        <!-- Header -->
        <div class="header clearfix Sticky">
            <a href="#menu" id="my-icon" class="d-lg-none  d-md-none menu-btn hamburger hamburger--spin">
                <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                </span>
            </a>

            <div id="main-nav">

                <div class="box-logo clearfix">
                    <?php if ($logo) { ?>
                        <?php if ($home == $og_url) { ?>
                            <span class="logo"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-fluid" /></span>
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>" class="logo"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-fluid" /></a>
                        <?php } ?>
                    <?php } ?>
                </div>

                <?php if ($categories) { ?>
                    <!-- Mega Menu desktop -->
                    <div class="mega-menu" class="clearfix">
                        <ul class="top-menu">
                            <?php foreach ($categories as $category) { ?>
                                <li>
                                <a href="<?php echo $category['href']; ?>" class="<?php echo $category['link_class']; ?>"><?php echo $category['name']; ?></a>
                                <?php if ($category['children']) { ?>
                                    <ul class="submenu <?php echo $category['sub_menu_class']; ?>">
                                    <?php foreach ($category['children'] as $child) { ?>
                                        <li><a href="<?php echo $child['href']; ?>" class="sub-item"><?php echo $child['name']; ?></a>
                                        <?php if ($child['children']) { ?>
                                            <ul>
                                            <?php foreach ($child['children'] as $subchild) { ?>
                                                <li>
                                                    <a href="<?php echo $subchild['href']; ?>"><?php echo $subchild['name']; ?></a>
                                                </li>
                                            <?php } ?>
                                            </ul>
                                        <?php } ?>
                                        </li>
                                    <?php } ?>
                                        <?php foreach ($category['banners'] as $banner) { ?>
                                            <li>
                                                <ul>
                                                    <li>
                                                        <?php if ($banner['link']) { ?>
                                                            <a href="<?php echo $banner['link']; ?>" class="link-image">
                                                                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
                                                            </a>
                                                        <?php } else { ?>
                                                            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
                                                        <?php } ?>
                                                    </li>
                                                    <li><h3 class="image-header"><?php echo $banner['title']; ?></h3></li>
                                                </ul>
                                            </li>
                                        <?php } ?>
                                    </ul>
                                <?php } ?>
                                </li>
                            <?php } ?>
                        </ul>
                    </div>
                    <!-- Mega Menu desktop end-->
                <?php } ?>
                <!-- Nav box left header -->
                <div class="nav-box clearfix">
                    <ul class="list-unstyled clearfix">
                        <li><a href="#" class="header-search d-none d-md-block"><i class="fal fa-search"></i></a>
                            <div class="search-box">
                                <?php echo $search; ?>
                            </div>
                        </li>
                        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" class="header-favorites" title="<?php echo $text_wishlist; ?>"><i class="fal fa-heart"></i></a></li>
                        <?php if ($cart_total_items) { ?>
                            <li><a href="<?php echo $shopping_cart; ?>" class="header-cart-ful" id="header-cart"><i class="fas fa-shopping-bag"></i><span class="count-shoping"><?php echo $cart_total_items; ?></span></a>
                        <?php } else { ?>
                            <li><a href="<?php echo $shopping_cart; ?>" class="header-cart" id="header-cart"><i class="fal fa-shopping-bag"></i><span class="count-shoping"></span></a></li>
                        <?php } ?></li>
                    </ul>
                </div>
                <!-- Nav box left header end-->
            </div>
        </div>
        <!-- Header end-->
        <?php echo $breadcrumbs; ?>