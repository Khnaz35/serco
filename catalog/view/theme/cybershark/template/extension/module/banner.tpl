<?php if ($banners) { ?>
    <div id="banner<?php echo $module; ?>" class="owl-carousel banner" style="opacity: 1;">
        <?php foreach ($banners as $banner) { ?>
            <div class="item">
                <?php if ($banner['link']) { ?>
                    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
                <?php } else { ?>
                    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
                <?php } ?>
            </div>
        <?php } ?>
    </div>
    <script type="text/javascript"><!--
    $('#banner<?php echo $module; ?>').owlCarousel({
        loop: true,
        autoplay: true,
        autoplayTimeout: 9100,
        items: 1,
        dots: false,
        nav: false,
        mouseDrag: false,
        touchDrag: false,
        pullDrag: false,
        freeDrag: false,
        animateOut: 'fadeOut',
        animateIn: 'fadeIn'
    });
    --></script>
<?php } ?>