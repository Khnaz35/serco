<?php if ($products) { ?>
    <div>
        <div class="container-module container-product-carousel container-viewed">
        	<div class="title-module">
                <span><?php echo $heading_title; ?></span>
            </div>
        	<div class="product-slider">
        		<div class="container-modules viewed carousel_numb_product_viewed<?php echo $module_productviewed_number;?> owl-carousel">
                    <?php foreach ($products as $product) { ?>			
                        <div class="item">

                            <div class="product-layout product-grid">
                                <div class="product-thumb">
                                    <div class="image">
                                        <a href="<?php echo $product['href']; ?>">
                                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                                        </a>
                                    </div>
                                    <div>
                                        <div class="caption">
                                            <div class="product-title">
                                                <a href="<?php echo $product['href']; ?>">
                                                    <?php echo $product['name']; ?>
                                                </a>
                                            </div>
                                            <?php if ($product['price']) { ?>
                                                <p class="price">
                                                    <?php if (!$product['special']) { ?>
                                                        <?php echo $product['price']; ?>
                                                    <?php } else { ?>
                                                        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                                    <?php } ?>
                                                </p>
                                            <?php } ?>
                                        </div>
                                        <div class="product-list-btns">
                                            <a class="product-list-more-btn" href="<?php echo $product['href']; ?>"><?php echo $text_more; ?></a>
                                            <?php if ($product['quantity'] > 0) { ?>
                                                <button class="product-list-buy-btn" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i></button>
                                            <?php } else { ?>
                                                <div class="product-list-no-buy-btn">
                                                    <i class="fa fa-shopping-cart"></i>
                                                </div>
                                            <?php } ?>
                                        
                                            <div class="clearfix">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
    $('.carousel_numb_product_viewed<?php echo $module_productviewed_number;?>').owlCarousel({
    	responsiveBaseWidth: ".carousel_numb_product_viewed<?php echo $module_productviewed_number;?>",
    	itemsCustom: [[0, 1], [360, 1], [500, 2], [678, 2], [768, 3], [990, 4], [1000,4]],
    	slideSpeed: 200,
    	paginationSpeed: 300,
    	navigation: true,
    	stopOnHover: true,			
    	mouseDrag: true,
    	touchDrag: true,
    	pagination: false,
    	autoPlay: true,
    	navigationText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
    });
    </script>
<?php } ?>