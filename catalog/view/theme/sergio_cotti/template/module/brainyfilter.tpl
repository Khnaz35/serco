<?php if (count($filters)) { ?>
<nav class=" filters-check">
    <form   class="bf-form"
            data-height-limit="<?php echo $limit_height_opts; ?>"
            data-visible-items="<?php echo $slidingOpts; ?>"
            data-hide-items="<?php echo $slidingMin; ?>"
            data-submit-type="<?php echo $settings['submission']['submit_type']; ?>"
            data-submit-delay="<?php echo (int)$settings['submission']['submit_delay_time']; ?>"
            data-resp-max-width="<?php echo (int)$settings['style']['responsive']['max_width']; ?>"
            data-resp-collapse="<?php echo (int)$settings['style']['responsive']['collapsed']; ?>"
            data-resp-max-scr-width ="<?php echo (int)$settings['style']['responsive']['max_screen_width']; ?>"
            method="get"
            action="index.php">
        <?php if ($currentRoute === 'product/search') { ?>
            <input type="hidden" name="route" value="product/search" />
        <?php } else { ?>
            <input type="hidden" name="route" value="product/category" />
        <?php } ?>

        <?php if ($currentPath) { ?>
            <input type="hidden" name="path" value="<?php echo $currentPath; ?>" />
        <?php } ?>

        <?php if ($manufacturerId) { ?>
            <input type="hidden" name="manufacturer_id" value="<?php echo $manufacturerId; ?>" />
        <?php } ?>

        <div class="sidebar ">
            <?php foreach ($filters as $i => $section) { ?>
                <?php if ($section['type'] == 'price') { ?>

                    <!-- box-slide-range -->
                    <div class="box-slide-range">
                        <h3 class="filter-title"><?php echo $lang_price; ?></h3>
                        <input id="range_03" type="text" class="irs-hidden-input" tabindex="-1" readonly=""  data-slider-type="2">
                        <input type="hidden" class="bf-range-min" name="bfp_price_min" value="<?php echo $lowerlimit; ?>" />
                        <input type="hidden" class="bf-range-max" name="bfp_price_max" value="<?php echo $upperlimit; ?>" />
                    </div>
                    <!-- box-slide-range end-->

                <?php } elseif ($section['type'] == 'category') { ?>

                    <?php $groupUID = 'c0'; ?>
                    <!-- box-manufacturer-pick -->
                    <div class="box-manufacturer-pick">
                        <h3 class="filter-title"><?php echo $lang_categories; ?></h3>
                        <?php foreach ($section['values'] as $cat) { $catId = $cat['id']; ?>
                            <div class="custom-control custom-radio">
                                <input  id="bf-attr-<?php echo $groupUID . '_' . $catId . '_' . $layout_id; ?>"
                                        data-filterid="bf-attr-<?php echo $groupUID . '_' . $catId; ?>"
                                        name="<?php echo "bfp_{$groupUID}"; ?><?php if ($section['control'] === 'checkbox') { echo "_{$catId}"; } ?>"
                                        value="<?php echo $catId; ?>"
                                        type="radio"
                                        class="custom-control-input">

                                <label  class="custom-control-label"
                                        for="bf-attr-<?php echo $groupUID . '_' . $catId . '_' . $layout_id; ?>"">

                                        <?php echo $cat['name']; ?>

                                </label>
                            </div>
                        <?php } ?>
                    </div>
                    <!-- box-manufacturer-pick end-->

                <?php } else { ?>
                    <?php $curGroupId = null; ?>

                    <?php foreach ($section['array'] as $groupId => $group) { ?>
                        <?php if (isset($group['group_id']) && $settings['behaviour']['attribute_groups']) { ?>
                            <?php if ($curGroupId != $group['group_id']) { ?>
                                <?php $curGroupId = $group['group_id']; ?>
                            <?php } ?>
                        <?php } ?>
                        <?php $groupUID = substr($section['type'], 0, 1) . $groupId; ?>
                        <?php $group['type'] = isset($group['type']) ? $group['type'] : 'checkbox'; ?>

                        <!-- box-color-pick -->
                        <div class="box-color-pick bf-attr-<?php echo $groupUID; ?>">
                            <h3 class="filter-title"><?php echo $group['name']; ?></h3>
                            <?php foreach ($group['values'] as $value) { ?>
                                <?php $valueId  = $value['id']; ?>
                                <div class="custom-control custom-radio bf-attr-<?php echo $groupUID; ?>">
                                    <input  type="<?php echo $group['type']; ?>"
                                            data-filterid="bf-attr-<?php echo $groupUID . '_' . $valueId; ?>"
                                            id="bf-attr-<?php echo $groupUID . '_' . $valueId . '_' . $layout_id; ?>"
                                            name="<?php echo "bfp_{$groupUID}"; ?><?php if ($group['type'] === 'checkbox') { echo "_{$valueId}"; } ?>"
                                            value="<?php echo $valueId; ?>"
                                            <?php if (isset($selected[$groupUID]) && in_array($valueId, $selected[$groupUID])) { ?>
                                            checked="true"
                                            <?php } ?>
                                            class="custom-control-input">




                                    <label class="custom-control-label" for="bf-attr-<?php echo $groupUID . '_' . $valueId . '_' . $layout_id; ?>"><?php echo $value['name']; ?></label>
                                </div>
                            <?php } ?>
                        </div>
                        <!-- box-color-pick end-->

                    <?php } ?>
                <?php } ?>
            <?php } ?>
        </div>
    </form>
</nav>
<script>
    var bfLang = {
        show_more : '<?php echo $lang_show_more; ?>',
        show_less : '<?php echo $lang_show_less; ?>',
        empty_list : '<?php echo $lang_empty_list; ?>'
    };
    BrainyFilter.requestCount = BrainyFilter.requestCount || <?php echo $settings['behaviour']['product_count'] ? 'true' : 'false'; ?>;
    BrainyFilter.requestPrice = BrainyFilter.requestPrice || <?php echo $settings['behaviour']['sections']['price']['enabled'] ? 'true' : 'false'; ?>;
    BrainyFilter.separateCountRequest = BrainyFilter.separateCountRequest || <?php echo $postponedCount ? 'true' : 'false'; ?>;
    BrainyFilter.min = BrainyFilter.min || <?php echo $priceMin; ?>;
    BrainyFilter.max = BrainyFilter.max || <?php echo $priceMax; ?>;
    BrainyFilter.lowerValue = BrainyFilter.lowerValue || <?php echo $lowerlimit; ?>;
    BrainyFilter.higherValue = BrainyFilter.higherValue || <?php echo $upperlimit; ?>;
    BrainyFilter.currencySymb = BrainyFilter.currencySymb || '<?php echo $currency_symbol; ?>';
    BrainyFilter.hideEmpty = BrainyFilter.hideEmpty || <?php echo (int)$settings['behaviour']['hide_empty']; ?>;
    BrainyFilter.baseUrl = BrainyFilter.baseUrl || "<?php echo $base; ?>";
    BrainyFilter.currentRoute = BrainyFilter.currentRoute || "<?php echo $currentRoute; ?>";
    BrainyFilter.selectors = BrainyFilter.selectors || {
        'container' : '<?php echo $settings['behaviour']['containerSelector']; ?>',
        'paginator' : '<?php echo $settings['behaviour']['paginatorSelector']; ?>'
    };
    <?php if ($redirectToUrl) { ?>

        BrainyFilter.redirectTo = BrainyFilter.redirectTo || "<?php echo $redirectToUrl; ?>";
    <?php } ?>
    jQuery(function() {
        if (! BrainyFilter.isInitialized) {
            BrainyFilter.isInitialized = true;
            if (typeof jQuery.fn.slider === 'undefined') {
                jQuery.getScript('catalog/view/javascript/jquery-ui.slider.min.js', function(){
                    jQuery('head').append('<link rel="stylesheet" href="catalog/view/theme/default/stylesheet/jquery-ui.slider.min.css" type="text/css" />');
                    BrainyFilter.init();
                });
            } else {
                BrainyFilter.init();
            }
        }
    });
    BrainyFilter.sliderValues = BrainyFilter.sliderValues || {};
    <?php if (count($filters)) { ?>

        <?php foreach ($filters as $i => $section) { ?>

            <?php if (isset($section['array']) && count($section['array'])) { ?>

                <?php foreach ($section['array'] as $groupId => $group) { ?>

                    <?php $groupUID = substr($section['type'], 0, 1) . $groupId; ?>
                    <?php if (in_array($group['type'], array('slider', 'slider_lbl', 'slider_lbl_inp'))) { ?>

                        BrainyFilter.sliderValues['<?php echo $groupUID; ?>'] = <?php echo json_encode($group['values']); ?>;
                    <?php } ?>
                <?php } ?>
            <?php } ?>
        <?php } ?>
    <?php } ?>




    if ($(window).width() < 768) {
        $('.filters-check').attr('id', 'shoppingbag');
    }

    if ($(window).width() > 768) {
        $('.filters-check').addClass('fixed-sidebar');
    }

    $(".fixed-sidebar").stick_in_parent();
    </script>
<?php } ?>