<?php echo $header; ?>

<div class="container">

    <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
    
    <h1 class="page_title"><?php echo $heading_title; ?></h1>
    
    <?php if ($success) { ?>
        <script type="text/javascript"><!--
            $(document).ready(function() {
                $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only"><?php echo $text_modal_close; ?></span></button><div class="modal-title"><?php echo $text_modal_success; ?></div></div><div class="modal-body"><div class="text-center"><div class="popup-name"><?php echo $success; ?></div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
                $('#modal-success').modal('show');
            }); 
        //--></script>
    <?php } ?>
    
    <div class="row">
        
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-6 col-lg-6 pull-center'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-9 col-lg-9 pull-right'; ?>
        <?php } else { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-12 col-lg-12'; ?>
        <?php } ?>
    
        <div id="content" class="<?php echo $class; ?>">
        
            <?php if ($content_top) { ?>
                <div id="content-top">
                    <?php echo $content_top; ?>
                </div>
            <?php } ?>
            
            
            <div class="page-content wishlist-content clearfix">
            
                <?php if ($products) { ?>
          
                    <div class="row">
                        <?php foreach ($products as $product) { ?>
                            
                <div class="product-layout product-grid <?php echo $product['label']; ?> col-xs-12 col-sm-6 col-md-6 col-lg-4">
             
                                <div class="product-category-outer">
                                        <div class="product-thumb">

                <div class="product-label-container">
                    <a href="<?php echo $product['href']; ?>">
                        <div class="product-label product-label-latest">
                            <span><?php echo $text_latest; ?></span>
                        </div>
                        <div class="product-label product-label-special">
                            <span><?php echo $text_special; ?></span>
                        </div>
                        <div class="product-label product-label-bestseller">
                            <span><?php echo $text_bestseller; ?></span>
                        </div>
                    </a>
                </div>
             
                                            
                                            <a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-times"></i></a>
                                            
                                            <div class="image">
                                                <a href="<?php echo $product['href']; ?>">
                                                    <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                                                </a>
                                            </div>
                                                    
                                            <div class="product-list-visible">
                                                <div class="product-title">
                                                    <a href="<?php echo $product['href']; ?>">
                                                        <?php echo $product['name']; ?>
                                                    </a>
                                                </div>
                                                
                                                <?php if ($product['price']) { ?>
                                                    <div class="price">
                                                        <?php if (!$product['special']) { ?>
                                                            <div class="price-regular"><?php echo $product['price']; ?></div>
                                                        <?php } else { ?>
                                                            <div class="price-new"><?php echo $product['special']; ?></div>
                                                            <?php /*<div class="price-old"><?php echo $product['price']; ?></div>*/ ?>
                                                        <?php } ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                                    
                                            <div class="product-list-hiden">
                                                <div class="product-list-info">
                                                    <?php if ($product['mopt_price']) { ?>
                                                        <div class="product-list-info-mopt-price">
                                                            <?php echo $text_mopt; ?> <?php echo $product['mopt_price']; ?>
                                                        </div>
                                                    <?php } ?>
                                                    
                                                    <div class="product-list-info-opt-price">
                                                        <a href="#get-price" onclick="get_price_open('<?php echo $product['product_id']; ?>'); return false;"><?php echo $text_known_opt; ?></a>
                                                    </div>
                                                </div>
                                                
                                                <?php if ($product['options']) { ?>
                                                    <div class="product-list-info-options">
                                                        <?php foreach ($product['options'] as $option) { ?>
                                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                <?php if ($option_value['quantity'] > 0) { ?>
                                                                    <div class="product-list-info-option">
                                                                        <?php echo $option_value['name']; ?>
                                                                    </div>
                                                                <?php } else { ?>
                                                                    <div class="product-list-info-option product-list-info-option-empty">
                                                                        <?php echo $option_value['name']; ?>
                                                                    </div>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        <?php } ?>
                                                        
                                                        <div class="clearfix">
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                
                                                <div class="product-list-more">
                                                    <a class="product-list-more-btn" href="<?php echo $product['href']; ?>"><?php echo $text_more; ?></a>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                            </div>
                        <?php } ?>
                    </div>
                <?php } else { ?>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="text_empty-container">
                                <?php echo $text_empty; ?>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
      
      
            <?php if ($content_bottom) { ?>
                <div id="content-bottom">
                    <?php echo $content_bottom; ?>
                </div>
            <?php } ?>
        </div>
        
        <?php if ($column_left) { ?>
            <div id="column-left" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_left; ?>
            </div>
        <?php } ?>
        
        <?php if ($column_right) { ?>
            <div id="column-right" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_right; ?>
            </div>
        <?php } ?>
        
    </div>
    
</div>

<?php echo $footer; ?>