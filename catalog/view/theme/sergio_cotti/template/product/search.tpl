<?php echo $header; ?>
<?php if ($content_top) { ?>
    <div id="content-top">
        <?php echo $content_top; ?>
    </div>
<?php } ?>
<!-- Content -->
<div class="content" id="content">
    <div class="container-fluid">
        <?php if ($column_left) { ?>
            <!-- sidebar -->
            <div class="filtes-box d-lg-none d-md-none">
                <a class="filters-button" href="#shoppingbag">Фильтры</a>
            </div>
            <!-- sidebar end-->
        <?php } ?>

        <div class="title-catalog">
            <h1 class=""><?php echo $heading_title; ?></h1>
        </div>


        <div id="search-form-container">
            <label class="control-label" for="input-search">
                <?php echo $entry_search; ?>
            </label>
            <div class="row">
                <div class="col-sm-5">
                    <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
                    <select name="category_id" class="form-control">
                        <option value="0">
                            <?php echo $text_category; ?>
                        </option>
                        <?php foreach ($categories as $category_1) { ?>
                            <?php if ($category_1['category_id'] == $category_id) { ?>
                                <option value="<?php echo $category_1['category_id']; ?>" selected="selected">
                                    <?php echo $category_1['name']; ?>
                                </option>
                            <?php } else { ?>
                                <option value="<?php echo $category_1['category_id']; ?>">
                                    <?php echo $category_1['name']; ?>
                                </option>
                            <?php } ?>
                            <?php foreach ($category_1['children'] as $category_2) { ?>
                                <?php if ($category_2['category_id'] == $category_id) { ?>
                                    <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <?php echo $category_2['name']; ?>
                                    </option>
                                <?php } else { ?>
                                    <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <?php echo $category_2['name']; ?>
                                    </option>
                                <?php } ?>
                                <?php foreach ($category_2['children'] as $category_3) { ?>
                                    <?php if ($category_3['category_id'] == $category_id) { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <?php echo $category_3['name']; ?>
                                        </option>
                                    <?php } else { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <?php echo $category_3['name']; ?>
                                        </option>
                                    <?php } ?>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </select>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="checkbox-inline">
                            <?php if ($sub_category) { ?>
                                <input type="checkbox" name="sub_category" value="1" checked="checked" />
                            <?php } else { ?>
                                <input type="checkbox" name="sub_category" value="1" />
                            <?php } ?>
                            <?php echo $text_sub_category; ?>
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="checkbox-inline">
                            <?php if ($description) { ?>
                            <input type="checkbox" name="description" value="1" id="description" checked="checked" />
                            <?php } else { ?>
                            <input type="checkbox" name="description" value="1" id="description" />
                            <?php } ?>
                            <?php echo $entry_description; ?>
                        </label>
                    </div>
                </div>

                <div class="col-sm-2">
                    <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
                </div>
            </div>
        </div>

        <div class="row justify-content-start">

            <?php if ($column_left) { ?>
                <!-- sidebar -->
                <div id="column-left" class="col-lg-2">
                    <?php echo $column_left; ?>
                </div>
                <!-- sidebar end-->
            <?php } ?>
            <?php if ($products) { ?>
                <!-- product-list -->
                <div class="product-list col-lg-10 col-md-8 ">
                    <div class="container-fluid">
                        <div class="row">
                            <?php foreach ($products as $product) { ?>
                                <!-- product-item -->
                                <div class="product-list-item col-lg-4 col-md-6 col-sm-6">
                                    <?php include('catalog/view/theme/'.$config_theme.'/template/product/product_block.tpl'); ?>
                                </div>
                                <!-- product-item end-->
                            <?php } ?>
                        </div>
                    </div>
                    <div class="box-pagination">
                        <nav>
                            <?php echo $pagination; ?>
                        </nav>
                    </div>
                </div>
                <!-- product-list end-->
            <?php }else{ ?>
                <div class="product-list col-lg-10 col-md-8 ">
                    <?php echo $text_empty; ?>
                </div>
            <?php } ?>

            <?php if ($column_right) { ?>
                <div id="column-right" class="col-lg-2">
                    <?php echo $column_right; ?>
                </div>
            <?php } ?>
        </div>
    </div>
    <?php if ($content_bottom) { ?>
        <div id="content-bottom">
            <?php echo $content_bottom; ?>
        </div>
    <?php } ?>
</div>
<!-- Content end-->
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
    url = 'index.php?route=product/search';

    var search = $('#content input[name=\'search\']').prop('value');

    if (search) {
        url += '&search=' + encodeURIComponent(search);
    }

    var category_id = $('#content select[name=\'category_id\']').prop('value');

    if (category_id > 0) {
        url += '&category_id=' + encodeURIComponent(category_id);
    }

    var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

    if (sub_category) {
        url += '&sub_category=true';
    }

    var filter_description = $('#content input[name=\'description\']:checked').prop('value');

    if (filter_description) {
        url += '&description=true';
    }

    location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
    if (e.keyCode == 13) {
        $('#button-search').trigger('click');
    }
});

$('select[name=\'category_id\']').on('change', function() {
    if (this.value == '0') {
        $('input[name=\'sub_category\']').prop('disabled', true);
    } else {
        $('input[name=\'sub_category\']').prop('disabled', false);
    }
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>