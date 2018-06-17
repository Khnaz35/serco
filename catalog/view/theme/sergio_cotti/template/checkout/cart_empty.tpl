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
            <h1 class="">
                <i class="fal fa-shopping-bag"></i>
                <?php echo $heading_title; ?>
            </h1>
        </div>
        <div class="row justify-content-start">

            <?php if ($column_left) { ?>
                <!-- sidebar -->
                <div id="column-left" class="col-lg-2">
                    <?php echo $column_left; ?>
                </div>
                <!-- sidebar end-->
            <?php } ?>

            <!-- page-cart -->
            <div class="page-cart col-12">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="text-center">
                                <a href="<?php echo $continue; ?>" class="btn btn-dark">
                                    <?php echo $button_shopping; ?>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- page-cart end-->

            <?php if ($column_right) { ?>
                <div id="column-right" class="col-lg-2">
                    <?php echo $column_right; ?>
                </div>
            <?php } ?>

        </div>
    </div>
    <?php if ($viewed_products) { ?>
        <div id="viewed-products">
            <?php echo $viewed_products; ?>
        </div>
    <?php } ?>

    <?php if ($content_bottom) { ?>
        <div id="content-bottom">
            <?php echo $content_bottom; ?>
        </div>
    <?php } ?>

</div>
<!-- Content end-->

<?php echo $footer; ?>