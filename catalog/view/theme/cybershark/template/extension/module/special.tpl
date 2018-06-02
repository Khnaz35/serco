    <?php if ($products) { ?>
        <div class="container-module container-product-carousel container-special">
            <div class="title-module">
                <span><?php echo $heading_title; ?></span>
            </div>
            
            <div class="product-slider">
                <div class="container-modules special carousel_numb_product_special<?php echo $module_productspecial_number; ?> owl-carousel">
                    <?php foreach ($products as $product) { ?>			
                        <div class="item">
                        
                            <div class="product-layout product-grid">
                                
                                <div class="product-thumb-outer">
                                    <div class="product-thumb">
                                        <div class="image">
                                            <a href="<?php echo $product['href']; ?>">
                                                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                                            </a>
                                        </div>
                                                
                                        <div class="product-list-visible">
                                            <div class="product-title">
                                                <a href="<?php echo $product['href']; ?>">
                                                    <?php echo $product['name']; ?>
                                                </a>
                                            </div>
                                            
                                            <?php if ($product['price']) { ?>
                                                <div class="price">
                                                    <?php if (!$product['special']) { ?>
                                                        <div class="price-regular"><?php echo $product['price']; ?></div>
                                                    <?php } else { ?>
                                                        <div class="price-new"><?php echo $product['special']; ?></div>
                                                        <?php /*<div class="price-old"><?php echo $product['price']; ?></div>*/ ?>
                                                    <?php } ?>
                                                </div>
                                            <?php } ?>
                                        </div>
                                                
                                        <div class="product-list-hiden">
                                            <div class="product-list-info">
                                                <?php if ($product['mopt_price']) { ?>
                                                    <div class="product-list-info-mopt-price">
                                                        <?php echo $text_mopt; ?> <?php echo $product['mopt_price']; ?>
                                                    </div>
                                                <?php } ?>
                                                
                                                <div class="product-list-info-opt-price">
                                                    <a href="#get-price" onclick="get_price_open('<?php echo $product['product_id']; ?>'); return false;"><?php echo $text_known_opt; ?></a>
                                                </div>
                                            </div>
                                            
                                            <?php if ($product['options']) { ?>
                                                <div class="product-list-info-options">
                                                    <?php foreach ($product['options'] as $option) { ?>
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                            <?php if ($option_value['quantity'] > 0) { ?>
                                                                <div class="product-list-info-option">
                                                                    <?php echo $option_value['name']; ?>
                                                                </div>
                                                            <?php } else { ?>
                                                                <div class="product-list-info-option product-list-info-option-empty">
                                                                    <?php echo $option_value['name']; ?>
                                                                </div>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    <?php } ?>
                                                    
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            <?php } ?>
                                            
                                            <div class="product-list-more">
                                                <a class="product-list-more-btn" href="<?php echo $product['href']; ?>"><?php echo $text_more; ?></a>
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
        <?php if ($position == 0) { ?>
        <script type="text/javascript">
            $(document).ready(function(){
                $(".carousel_numb_product_special<?php echo $module_productspecial_number; ?>").owlCarousel({
                    margin:0,
                    nav:true,
                    dots:false,
                    navText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
                    responsive:{
                        0:{
                            items:1
                        },
                        767:{
                            items:2
                        },
                        990:{
                            items:3
                        },
                        1200:{
                            items:4
                        }
                    }
                });
            });
        </script>
        <?php } else { ?>
        <script type="text/javascript">
            $(document).ready(function(){
                $(".carousel_numb_product_special<?php echo $module_productspecial_number; ?>").owlCarousel({
                    margin:0,
                    nav:true,
                    dots:false,
                    navText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
                    responsive:{
                        0:{
                            items:1
                        },
                        767:{
                            items:1
                        },
                        990:{
                            items:1
                        },
                        1200:{
                            items:1
                        }
                    }
                });
            });
        </script>
        <?php } ?>
    <?php } ?><!-- if $products -->