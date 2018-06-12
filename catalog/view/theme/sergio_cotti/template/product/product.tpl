<?php echo $header; ?>

<?php if ($content_top) { ?>
    <div id="content-top">
        <?php echo $content_top; ?>
    </div>
<?php } ?>

<?php if ($column_left) { ?>
    <?php echo $column_left; ?>
<?php } ?>

<!-- Content -->
<div id="content" class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-7 ">
                <div class="box-img-wrap clearfix">
                    <?php if ($popup) { ?>
                        <div class="box-main-img">
                            <img src="<?php echo $popup; ?>" alt="<?php echo $heading_title; ?>" class="img-fluid">
                        </div>
                    <?php } ?>

                    <?php if ($images) { ?>
                        <div class="box-switch-img">
                            <!-- Swiper -->
                            <div class="swiper-container gallery-top ">
                                <div class="swiper-wrapper">
                                    <?php foreach ($images as $image) { ?>
                                        <div class="swiper-slide">
                                            <div class="swiper-zoom-container zoom">
                                                <img src="<?php echo $image; ?>" alt="<?php echo $heading_title; ?>">
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>
                                <!-- Add Arrows -->
                                <div class="swiper-button-next swiper-button-white"></div>
                                <div class="swiper-button-prev swiper-button-white"></div>
                            </div>
                            <div class="swiper-container gallery-thumbs">
                                <div class="swiper-wrapper">
                                    <?php foreach ($images as $image) { ?>
                                        <div class="swiper-slide">
                                            <div class="swiper-zoom-container">
                                                <img src="<?php echo $image; ?>" alt="<?php echo $heading_title; ?>">
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <script>
                            $(document).ready(function() {
                                var galleryTop = new Swiper('.gallery-top', {
                                    spaceBetween: 23,
                                    slidesPerView: 1,
                                    navigation: {
                                        nextEl: '.swiper-button-next',
                                        prevEl: '.swiper-button-prev',
                                    },
                                });
                                var galleryThumbs = new Swiper('.gallery-thumbs', {
                                    spaceBetween: 10,
                                    centeredSlides: true,
                                    slidesPerView: 'auto',
                                    touchRatio: 0.2,
                                    slideToClickedSlide: true,
                                });
                                galleryTop.controller.control = galleryThumbs;
                                galleryThumbs.controller.control = galleryTop;
                            });
                        </script>
                    <?php } ?>
                </div>
                <!-- Initialize Swiper -->
            </div>
            <div class="col-lg-5 sticky_column" id="stickke">
                <div class="product-toolbar clearfix">
                    <?php echo $breadcrumbs; ?>

                    <!-- page nav -->
                    <div class="page-navigation">
                        <a href="#" class="next-page-navigation"><i class="fal fa-long-arrow-left"></i></a>
                        <a href="#" class="prev-page-navigation"><i class="fal fa-long-arrow-right"></i></a>
                    </div>
                    <!-- page nav end-->
                </div>

                <div id="product" class="product-actions">

                    <!--  product-features -->
                        <div class="product-features">
                            <h1 class="product-name"><?php echo $heading_title; ?></h1>
                            <?php if ($sku) { ?>
                                <span class="product-reference"><?php echo $text_sku; ?> <?php echo $sku; ?></span>
                            <?php } ?>
                        </div>
                    <!--  product-features -->

                    <!-- box-product-price -->
                        <?php if ($price) { ?>
                            <div class="box-product-price clearfix">
                                <span class="price-retail"><?php echo $price; ?> <span>грн.</span></span>
                                <a href="#" class="sale-price"><?php echo $text_opt; ?></a>
                            </div>
                        <?php } ?>
                    <!-- box-product-price end-->

                    <!-- product-color-pick -->
                        <?php  if(isset($product_color)){ ?>
                            <div class="product-color-pick">
                                <ul class="product_colors list-unstyled">
                                    <?php  foreach ($product_color as $color) { ?>
                                        <li class="product_color_selected">
                                            <div class="product_color_selected_container">
                                                <img src="image/<?php echo $color['color_image']; ?>" title="<?php echo $color['name']; ?>" alt="<?php echo $color['name']; ?>">
                                            </div>
                                        </li>
                                        <input type="hidden" name="option[<?php echo $color['product_option_id']; ?>]" value="<?php echo $color['product_option_value_id']; ?>">
                                    <?php } ?>
                                    <?php  foreach ($relative_products_color as $color) { ?>
                                        <li class="product_color_not_selected">
                                            <div class="product_color_not_selected_container">
                                                <a href="<?php echo $color['link']; ?>">
                                                    <img src="image/<?php echo $color['color_image']; ?>" title="<?php echo $color['name']; ?>" alt="<?php echo $color['name']; ?>">
                                                </a>
                                            </div>
                                        </li>
                                    <?php } ?>
                                </ul>
                            </div>
                        <?php } ?>
                    <!-- product-color-pick end-->

                    <!-- box-size-pick -->
                        <?php if ($options) { ?>
                            <?php foreach ($options as $option) { ?>
                                <?php if ($option['type'] == 'radio') { ?>
                                    <div class="box-size-pick-product">
                                        <span class="size-pick-title"><?php echo $option['name']; ?>:</span>
                                        <?php $i = 1; ?>
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <?php if ($option_value['quantity'] > 0) { ?>
                                                <span class="custom-control custom-radio">
                                                    <?php if ($i === 1) { ?>
                                                        <input  type="radio"
                                                                id="radio<?php echo $option_value['product_option_value_id']; ?>"
                                                                value="<?php echo $option_value['product_option_value_id']; ?>"
                                                                name="option[<?php echo $option['product_option_id']; ?>]"
                                                                class="custom-control-input"
                                                                checked >
                                                    <?php }else{ ?>
                                                        <input  type="radio"
                                                                id="radio<?php echo $option_value['product_option_value_id']; ?>"
                                                                value="<?php echo $option_value['product_option_value_id']; ?>"
                                                                name="option[<?php echo $option['product_option_id']; ?>]"
                                                                class="custom-control-input" >
                                                    <?php } ?>
                                                    <label class="custom-control-label" for="radio<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?></label>
                                                </span>
                                            <?php } ?>
                                            <?php $i++; ?>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    <!-- box-size-pick end-->

                    <!-- box-table-size -->
                        <div class="box-table-size">
                            <a class="table-size-link" href="<?php echo $dimentions_table; ?>"><?php echo $text_dimentions_table; ?></a>
                        </div>
                        <script type="text/javascript">
                            $(document).delegate('.table-size-link', 'click', function(e) {
                                e.preventDefault();

                                $('#modal-table-size').remove();

                                var element = this;

                                $.ajax({
                                    url: $(element).attr('href'),
                                    type: 'get',
                                    dataType: 'html',
                                    success: function(data) {
                                        html  = '<div id="modal-table-size" class="modal">';
                                        html += '  <div class="modal-dialog">';
                                        html += '    <div class="modal-content">';
                                        html += '      <div class="modal-header">';
                                        html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
                                        html += '        <div class="modal-title">' + $(element).text() + '</div>';
                                        html += '      </div>';
                                        html += '      <div class="modal-body">' + data + '</div>';
                                        html += '    </div';
                                        html += '  </div>';
                                        html += '</div>';

                                        $('body').append(html);

                                        $('#modal-table-size').modal('show');
                                    }
                                });

                            });
                        </script>
                    <!-- box-table-size end-->

                    <?php if ($quantity > 0) { ?>
                        <div class="box-cart-button clearfix d-flex justify-content-center">
                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                            <input id="input-quantity" type="number" name="quantity" value="<?php echo $minimum; ?>" min="<?php echo $minimum; ?>" max="<?php echo $quantity; ?>" step="1" />
                            <a href="#" id="button-cart" class="addcart"><?php echo $button_cart; ?></a>
                            <a href="#" data-product_id="<?php echo $product_id; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');return false" class="addwish"><i class="fal fa-heart"></i></a>
                        </div>
                    <?php } ?>

                    <div class="box-product-pay-delivery d-flex justify-content-center">
                        <div class="product-delivery">
                            <img src="catalog/view/theme/<?php echo $config_theme; ?>/assets/img/car.png" alt="delivery">
                            <a href="#">Доставка</a>
                        </div>
                        <div class="product-pay">
                            <img src="catalog/view/theme/<?php echo $config_theme; ?>/assets/img/oplata.png" alt="delivery">
                            <a href="#">Оплата</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="produt-tabs">
            <ul class="nav nav-pills mb-3  d-flex justify-content-center" id="pills-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link line-hover active" id="pills-description-tab" data-toggle="pill" href="#pills-description" role="tab" aria-controls="pills-description" aria-selected="true"><?php echo $tab_description; ?></a>
                </li>
                <?php if ($review_status) { ?>
                    <li class="nav-item">
                        <a class="nav-link line-hover" id="pills-review-tab" data-toggle="pill" href="#pills-review" role="tab" aria-controls="pills-review" aria-selected="false"><?php echo $tab_review; ?></a>
                    </li>
                <?php } ?>
                <?php if ($tab_guarantee) { ?>
                    <li class="nav-item">
                        <a class="nav-link line-hover" id="pills-return-tab" data-toggle="pill" href="#pills-return" role="tab" aria-controls="pills-return" aria-selected="false"><?php echo $tab_return; ?></a>
                    </li>
                <?php } ?>
            </ul>

            <div class="tab-content  d-flex justify-content-center" id="pills-tabContent">
                <!-- description -->
                    <div class="tab-pane fade show active text-left" id="pills-description" role="tabpanel" aria-labelledby="pills-description-tab">
                        <?php echo $description; ?>
                    </div>
                <!-- description -->

                <!-- reviews -->
                    <?php if ($review_status) { ?>
                        <div class="tab-pane fade" id="pills-review" role="tabpanel" aria-labelledby="pills-review-tab">
                            <div class="comment_container">
                            </div>
                            <div class="box-product-form">
                                <span class="comment-reply-title"><?php echo $text_write; ?></span>
                                <div class="stars-reting text-left">
                                    <input type="text" id="input-stars" name="rating" class="kv-fa rating-loading" value="3.5" dir="ltr" data-size="xs">
                                    <div class="clearfix"></div>
                                </div>
                                <p class="text-left product-textarea-name">
                                    <label for="input-review" class="label-wait1"><?php echo $entry_review; ?> <span class="required "></span></label>
                                    <textarea name="text" id="input-review"></textarea>
                                </p>
                                <p class="text-left product-input-name">
                                    <label for="input-name" class="label-wait2"><?php echo $entry_name; ?> <span class="required">*</span></label>
                                    <input type="text" name="name" id="input-name" required>
                                </p>
                                <p class="text-left product-input-email">
                                    <label for="comment" class="label-wait3">Email <span class="required">*</span></label>
                                    <input type="text" required>
                                </p>
                                <p class="form-submit active">
                                    <input name="submit" type="submit" id="button-review" class="product-input-submit">
                                </p>
                            </div>
                        </div>
                    <?php } ?>
                <!-- reviews -->
                <!-- Warranty & Returns -->
                    <?php if ($tab_guarantee) { ?>
                        <div class="tab-pane fade text-left" id="pills-return" role="tabpanel" aria-labelledby="pills-return-tab">
                            <?php echo $tab_guarantee; ?>
                        </div>
                    <?php } ?>
                <!-- Warranty & Returns -->
            </div>
        </div>
        <?php if ($column_right) { ?>
            <div id="column-right">
                <?php echo $column_right; ?>
            </div>
        <?php } ?>
        <!-- Slider related -->
        <?php if ($products) { ?>
            <div id="slider-related">
                <h2 class="text-center title-slider"><?php echo $text_related; ?></h2>
                <div class="swiper-container swiper-container-js swiper-container-horizontal swiper-initiated product-list">
                    <div class="swiper-wrapper">
                        <!-- product-item -->
                            <?php foreach ($products as $product) { ?>
                                <div class="product-list-item swiper-slide">
                                    <?php include('catalog/view/theme/'.$config_theme.'/template/product/product_block.tpl'); ?>
                                </div>
                            <?php } ?>
                        <!-- product-item end-->
                    </div>
                    <!-- If we need navigation buttons-->
                    <div class="swiper-button-prev swiper-button-disabled"><i class="fal fa-arrow-left"></i></div>
                    <div class="swiper-button-next"><i class="fal fa-arrow-right"></i></div>
                </div>
            </div>
            <script>
            var swiper = new Swiper('#slider-related > .swiper-container', {
                slidesPerView: 5,
                spaceBetween: 30,
                autoplay: {
                    delay: 5000,
                },
                // Navigation arrows
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                breakpoints: {
                    // when window width is <= 320px
                    320: {
                        slidesPerView: 1,
                        spaceBetween: 10
                    },
                    // when window width is <= 480px
                    480: {
                        slidesPerView: 1,
                        spaceBetween: 20
                    },
                    // when window width is <= 640px
                    768: {
                        slidesPerView: 2,
                        spaceBetween: 30
                    }
                },
            });
            </script>
        <?php } ?>
        <!-- Slider related end-->
        <?php if ($content_bottom) { ?>
            <div id="content-bottom">
                <?php echo $content_bottom; ?>
            </div>
        <?php } ?>
    </div>
</div>
<!-- Content end-->

<script type="text/javascript">
$('#button-cart').on('click', function(e) {
    e.preventDefault()
    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
        dataType: 'json',
        success: function(json) {
            $('.alert, .text-danger').remove();
            $('.form-group').removeClass('has-error');

            if (json['error']) {
                if (json['error']['option']) {
                    for (i in json['error']['option']) {
                        var element = $('#input-option' + i.replace('_', '-'));

                        if (element.parent().hasClass('input-group')) {
                            element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                        } else {
                            element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                        }
                    }
                }

                if (json['error']['recurring']) {
                    $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                }

                // Highlight any found errors
                $('.text-danger').parent().addClass('has-error');
            }

            if (json['success']) {
                $('#content').parent().before('<div id="modal-addcart" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">' + json['success'] + '</div></div><div class="modal-body"><div class="text-center"><img style="margin:10px 0px;" src="'+ json['image_cart'] +'"  /><br></div><div class="text-center"><div class="popup-name">' + json['success_name'] + '</div><br></div><div class="text-center"><div class="popup-btn-left"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="popup-btn-right"><a href=' + link_checkout + ' class="btn btn-primary">'+ button_checkout +'</a></div><div class="clearfix"></div></div></div>    </div></div></div>');
                $('#modal-addcart').modal('show');

                setTimeout(function () {
                    $('#cart').load('index.php?route=common/cart/info');
                    $('#cart_fixed').load('index.php?route=common/cart_fixed/info')
                }, 100);

            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
</script>

<script type="text/javascript"><!--
$('.date').datetimepicker({
    pickTime: false
});

$('.datetime').datetimepicker({
    pickDate: true,
    pickTime: true
});

$('.time').datetimepicker({
    pickDate: false
});
//--></script>
<script type="text/javascript"><!--
$('#pills-review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#pills-review').fadeOut('slow');

    $('#pills-review').load(this.href);

    $('#pills-review').fadeIn('slow');
});

$('.comment_container').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function(e) {
    e.preventDefault();
    $.ajax({
        url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
        type: 'post',
        dataType: 'json',
        data: $('.box-product-form input[type=\'text\'], .box-product-form textarea'),
        beforeSend: function() {
            $('#button-review').button('loading');
        },
        complete: function() {
            $('#button-review').button('reset');
        },
        success: function(json) {
            $('.alert-success, .alert-danger').remove();

            if (json['error']) {
                $('#content').parent().before('<div id="modal-warning" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Внимание!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['error'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>    </div></div></div>');
                $('#modal-warning').modal('show');
            }

            if (json['success']) {
                $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Успех!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['success'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div> </div></div></div>');
                $('#modal-success').modal('show');
                $('input[name=\'name\']').val('');
                $('textarea[name=\'text\']').val('');
                $('input[name=\'rating\']:checked').prop('checked', false);
            }
        }
    });
    grecaptcha.reset();
});

$(document).ready(function() {
    var hash = window.location.hash;
    if (hash) {
        var hashpart = hash.split('#');
        var  vals = hashpart[1].split('-');
        for (i=0; i<vals.length; i++) {
            $('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
            $('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
        }
    }
})
//--></script>
<script>
$(document).ready(function() {
    var galleryTop = new Swiper('.gallery-top', {
        spaceBetween: 23,
        slidesPerView: 1,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
    var galleryThumbs = new Swiper('.gallery-thumbs', {
        spaceBetween: 10,
        centeredSlides: true,
        slidesPerView: 'auto',
        touchRatio: 0.2,
        slideToClickedSlide: true,
    });
    galleryTop.controller.control = galleryThumbs;
    galleryThumbs.controller.control = galleryTop;
});
</script>
<script>
$(".fixed-sidebar").stick_in_parent();
</script>
<script>
$('.product-textarea-name').on('click', function(e) {
    $('.label-wait1').addClass("active-label");
});
$('.product-input-name').on('click', function(e) {
    $('.label-wait2').addClass("active-label");
});
$('.product-input-email').on('click', function(e) {
    $('.label-wait3').addClass("active-label");
});
</script>
<script>
$(document).ready(function() {
    $('.zoom').zoom();
});
</script>
<script>
$(document).ready(function() {
    $('#input-stars').rating({
        theme: 'krajee-fa',
        filledStar: '<i class="fas fa-star"></i>',
        emptyStar: '<i class="fal fa-star"></i>',
        showCaption: false
    });
});
</script>
<script>
$("input[type='number']").InputSpinner()
</script>
<?php echo $footer; ?>