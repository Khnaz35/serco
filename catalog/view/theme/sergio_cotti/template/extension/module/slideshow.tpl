<?php if ($banners) { ?>
    <div id="main-slider<?php echo $module; ?>">
        <div class="swiper-container">
            <div class="swiper-wrapper">
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
            <!-- If we need pagination -->
            <div id="swiper-pagination<?php echo $module; ?>" class="swiper-pagination"></div>
        </div>
    </div>
    <script>
        var mySwiper = new Swiper ('#main-slider<?php echo $module; ?> > .swiper-container', {
            // Optional parameters
            direction: 'horizontal',
            slidesPerView: 'auto',
            loop: true,
            freeMode: true,
            autoplay: {
                delay: 4000,
                disableOnInteraction: true,
            },

            // If we need pagination
            pagination: {
                el: '#swiper-pagination<?php echo $module; ?>',
                clickable: true,
            },
            lazy: {
                loadPrevNext: true,
            },
        })
    </script>
<?php } ?>