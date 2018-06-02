
    <div class="swiper-slide">
        <a href="<?php echo $product['href']; ?>" class="box-catalog">
            <div class="add-cart">
                <p class="add-cart-label add-cart-first-step-js add-cart-step--active">
                    <span class="variationA"><?php echo $button_cart; ?></span>
                </p>
                <?php if ($product['options']) { ?>
                    <?php foreach ($product['options'] as $option) { ?>
                        <p class="add-cart-label"><?php echo $text_choose_size; ?></p>
                        <div class="add-cart-sizes-container ">
                            <div class="add-cart-sizes add-cart-sizes-js add-cart-sizes--selected">
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <?php if ($option_value['quantity'] > 0) { ?>
                                        <span class="add-cart-sizes-size"
                                        onclick="cart.add('<?php echo $product['product_id']; ?>', '1', '<?php echo $option['product_option_id']; ?>', '<?php echo $option_value['product_option_value_id']; ?>')"><?php echo $option_value['name']; ?></span>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                    <?php } ?>
                <?php } ?>
            </div>
            <div class="box-img-new-now">
                <img class="img-fluid" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
            </div>
            <div class="product-list-info">
                <span class="product-list-fav" onlick="wishlist.add(<?php echo $product['product_id']; ?>)"><i class="fal fa-heart"></i></span>
                <span class="product-list-name"><?php echo $product['name']; ?></span>
                <?php if ($product['price']) { ?>
                    <?php if (!$product['special']) { ?>
                        <span class="product-list-price"><?php echo $product['price']; ?></span>
                    <?php } else { ?>
                        <span class="product-list-price"><?php echo $product['special']; ?></span>
                        <span class="product-list-price"><?php echo $product['price']; ?></span>
                    <?php } ?>
                <?php } ?>
            </div>
        </a>
    </div>