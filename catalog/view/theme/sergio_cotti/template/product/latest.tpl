<?php echo $header; ?>

<?php if ($content_top) { ?>
    <div id="content-top">
        <?php echo $content_top; ?>
    </div>
<?php } ?>

<!-- Content -->
<div class="content" id="content">
    <div class="container-fluid">
        <div class="title-catalog">
            <h1 class=""><?php echo $heading_title; ?></h1>
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
                </div>
                <!-- product-list end-->
            <?php } else { ?>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="text_empty-container">
                        <?php echo $text_empty; ?>
                    </div>
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
<?php echo $footer; ?>