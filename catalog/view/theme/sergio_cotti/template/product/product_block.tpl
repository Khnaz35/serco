<div class="box-catalog">
    <div class="add-cart">
        <p class="add-cart-label add-cart-first-step-js add-cart-step--active">
            <span class="variation"><?php echo $button_cart; ?></span>
        </p>
        <?php if ($product['options']) { ?>
            <div class="add-cart-sizes-container">
                <?php foreach ($product['options'] as $option) { ?>
                    <p class="add-cart-label"><?php echo $text_choose_size; ?></p>
                    <div class="add-cart-sizes add-cart-sizes-js add-cart-sizes--selected">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                            <?php if ($option_value['quantity'] > 0) { ?>
                                <span class="custom-control custom-radio">
                                    <input  onclick="cart.add('<?php echo $product['product_id']; ?>', '1', '<?php echo $option['product_option_id']; ?>', '<?php echo $option_value['product_option_value_id']; ?>')"
                                            type="radio"
                                            id="customRadio50"
                                            name="customRadio-manu"
                                            class="custom-control-input">
                                    <label class="custom-control-label" for="customRadio50"><?php echo $option_value['name']; ?></label>
                                </span>
                            <?php } ?>
                        <?php } ?>
                    </div>
                <?php } ?>
            </div>
        <?php } ?>
    </div>
    <a href="#" class="box-img-new-now">
        <?php if (!empty($labels)) { ?>
            <?php foreach ($labels as $label) { ?>
                <span class="ribbons">
                    <span class="<?php echo $label['class']; ?> ribbon"><?php echo $label['text']; ?></span>
                </span>
            <?php } ?>
        <?php } ?>
        <img class="img-fluid" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
    </a>
    <div class="product-list-info">
        <span   class="product-list-fav"
                data-product_id="<?php echo $product['product_id']; ?>"
                onclick="wishlist.add(<?php echo $product['product_id']; ?>)"><i class="fal fa-heart"></i></span>
        <span class="product-list-name"><?php echo $product['name']; ?></span>
        <?php if ($product['price']) { ?>
            <?php if (!$product['special']) { ?>
                <span class="product-list-price"><?php echo $product['price']; ?></span>
            <?php } else { ?>
                <span class="product-list-price"><?php echo $product['special']; ?></span>
            <?php } ?>
        <?php } ?>
        <span class="product-list-btn d-lg-none d-md-none variation"><a>Купить</a></span>
    </div>
</div>