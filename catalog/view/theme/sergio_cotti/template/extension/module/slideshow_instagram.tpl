<?php if ($banners) { ?>
    <!-- Slider Instagram  -->
    <div id="instagram-box" class="instagram-box<?php echo $module; ?>">
        <h2 class="text-center title-slider">Instagram sergio_cotti.fashion</h2>
        <!-- Slider main container -->
        <div class="swiper-container">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
                <!-- Slides -->
                <?php foreach ($banners as $banner) { ?>
                    <div class="swiper-slide">
                        <?php if ($banner['link']) { ?>
                            <a href="<?php echo $banner['link']; ?>"><img class="img-fluid" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"></a>
                        <?php } else { ?>
                            <img class="img-fluid" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>">
                        <?php } ?>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
    <!-- Slider Instagram  end-->
    <script>
        var swiper = new Swiper('.instagram-box<?php echo $module; ?> > .swiper-container', {
            slidesPerView: 8,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                    delay: 2000,
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