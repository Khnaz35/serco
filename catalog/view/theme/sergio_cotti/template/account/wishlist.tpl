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

<?php if ($success) { ?>
    <script type="text/javascript"><!--
        $(document).ready(function() {
            $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only"><?php echo $text_modal_close; ?></span></button><div class="modal-title"><?php echo $text_modal_success; ?></div></div><div class="modal-body"><div class="text-center"><div class="popup-name"><?php echo $success; ?></div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>    </div></div></div>');
            $('#modal-success').modal('show');
        });
    //--></script>
<?php } ?>

<?php echo $footer; ?>