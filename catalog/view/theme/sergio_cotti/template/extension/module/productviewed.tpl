<?php if ($products) { ?>
    <!-- Slider you wathing -->
    <div id="slider-you-watching<?php echo $module_productviewed_number; ?>">
        <h2 class="text-center title-slider"><?php echo $heading_title; ?></h2>
        <div class="swiper-container swiper-container-js swiper-container-horizontal swiper-initiated">
            <div class="swiper-wrapper">
                <?php foreach ($products as $product) { ?>
                    <div class="swiper-slide">
                        <?php include('catalog/view/theme/'.$config_theme.'/template/product/product_block.tpl'); ?>
                    </div>
                <?php } ?>
            </div>
            <!-- If we need navigation buttons-->
            <div id="prev<?php echo $module_productviewed_number; ?>" class="swiper-button-prev swiper-button-disabled"><i class="fal fa-arrow-left"></i></div>
            <div id="next<?php echo $module_productviewed_number; ?>" class="swiper-button-next"><i class="fal fa-arrow-right"></i></div>
        </div>
    </div>
    <!-- Slider you wathing end-->
    <script>
            var swiper = new Swiper('#slider-you-watching<?php echo $module_productviewed_number; ?> > .swiper-container', {
                slidesPerView: 5,
                spaceBetween: 30,
                autoplay: {
                        delay: 5000,
                    },
                // Navigation arrows
                        navigation: {
                            nextEl: '#prev<?php echo $module_productviewed_number; ?>',
                            prevEl: '#next<?php echo $module_productviewed_number; ?>',
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