<?php if ($products) { ?>
    <!-- Slider New item -->
    <div id="slider-new-now<?php echo $module_productlatest_number; ?>" style="position: relative;">
        <h2 class="text-center title-slider"><?php echo $heading_title; ?></h2>
        <div class="swiper-container swiper-container-js swiper-container-horizontal swiper-initiated">
            <div class="swiper-wrapper">
                <?php foreach ($products as $product) { ?>
                    <?php include('catalog/view/theme/'.$config_theme.'/template/product/product_block.tpl'); ?>
                <?php } ?>
            </div>
            </div>
            <!-- If we need navigation buttons-->
            <div id="prev<?php echo $module_productlatest_number; ?>" class="swiper-button-prev swiper-button-disabled"><i class="fal fa-arrow-left"></i></div>
            <div id="next<?php echo $module_productlatest_number; ?>" class="swiper-button-next"><i class="fal fa-arrow-right"></i></div>
        </div>
    </div>
    <!-- Slider New item end-->
    <script>
        var swiper = new Swiper('#slider-new-now<?php echo $module_productlatest_number; ?> > .swiper-container', {
            slidesPerView: 4,
            spaceBetween: 30,
            /*centeredSlides: true,*/
            // Navigation arrows
            navigation: {
                nextEl: '#prev<?php echo $module_productlatest_number; ?>',
                prevEl: '#next<?php echo $module_productlatest_number; ?>',
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