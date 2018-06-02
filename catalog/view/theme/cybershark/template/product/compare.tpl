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
            
            <div class="page-content compare-content clearfix">
                <?php if ($products) { ?>
                    <table class="table table-bordered">
                        <?php /*<thead>
                            <tr>
                                <td colspan="<?php echo count($products) + 1; ?>">
                                    <?php echo $text_product; ?>
                                </td>
                            </tr>
                        </thead>*/ ?>
                        <tbody>
                            <tr>
                                <td>
                                    <?php echo $text_name; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td>
                                        <a target="_blank" class="compare-product-name" href="<?php echo $product['href']; ?>">
                                            <?php echo $product['name']; ?>
                                        </a>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $text_image; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td class="text-left">
                                        <?php if ($product['thumb']) { ?>
                                            <a target="_blank" class="compare-product-image <?php echo $product['label']; ?>" href="<?php echo $product['href']; ?>">

                                                <div class="product-label-container">
                                                    <div class="product-label product-label-latest">
                                                        <span><?php echo $text_latest; ?></span>
                                                    </div>
                                                    <div class="product-label product-label-special">
                                                        <span><?php echo $text_special; ?></span>
                                                    </div>
                                                    <div class="product-label product-label-bestseller">
                                                        <span><?php echo $text_bestseller; ?></span>
                                                    </div>
                                                </div>
                                                
                                                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" />
                                            </a>
                                        <?php } ?>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $text_price; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td>
                                        <div class="compare-product-price">
                                                <div class="price">
                                                    <?php if (!$product['special']) { ?>
                                                        <div class="price-regular"><?php echo $product['price']; ?></div>
                                                    <?php } else { ?>
                                                        <div class="price-new"><?php echo $product['special']; ?></div>
                                                        <?php /*<div class="price-old"><?php echo $product['price']; ?></div>*/ ?>
                                                    <?php } ?>
                                                </div>
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
                                        </div>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                                <tr>
                                    <td>
                                        <?php echo $text_dimension; ?>
                                    </td>
                                    <?php foreach ($products as $product) { ?>
                                        <td>
                                            <?php if ($product['options']) { ?>
                                                <div class="compare-product-info-options">
                                                    <?php foreach ($product['options'] as $option) { ?>
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                            <?php if ($option_value['quantity'] > 0) { ?>
                                                                <div class="compare-product-info-option">
                                                                    <?php echo $option_value['name']; ?>
                                                                </div>
                                                            <?php } else { ?>
                                                                <div class="compare-product-info-option compare-product-info-option-empty">
                                                                    <?php echo $option_value['name']; ?>
                                                                </div>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    <?php } ?>
                                                    
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    <?php } ?>
                                </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $text_model; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td>
                                        <?php echo $product['model']; ?>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $text_sku; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td>
                                        <?php echo $product['sku']; ?>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                            <tr>
                                <td>
                                    <?php echo $text_availability; ?>
                                </td>
                                <?php foreach ($products as $product) { ?>
                                    <td>
                                        <?php echo $product['availability']; ?>
                                    </td>
                                <?php } ?>
                            </tr>
                            
                            <?php if ($review_status) { ?>
                                <tr>
                                    <td>
                                        <?php echo $text_rating; ?>
                                    </td>
                                    <?php foreach ($products as $product) { ?>
                                        <td class="rating">
                                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($product['rating'] < $i) { ?>
                                                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                <?php } else { ?>
                                                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                <?php } ?>
                                            <?php } ?>
                                            <br />
                                            <?php echo $product['reviews']; ?>
                                        </td>
                                    <?php } ?>
                                </tr>
                            <?php } ?>
                        </tbody>
                        
                        <?php foreach ($attribute_groups as $attribute_group) { ?>
                            <?php /*<thead>
                                <tr>
                                    <td colspan="<?php echo count($products) + 1; ?>">
                                        <?php echo $attribute_group['name']; ?>
                                    </td>
                                </tr>
                            </thead>*/ ?>
                            
                            <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
                                <tbody>
                                    <tr>
                                        <td>
                                            <?php echo $attribute['name']; ?>
                                        </td>
                                        <?php foreach ($products as $product) { ?>
                                            <?php if (isset($product['attribute'][$key])) { ?>
                                                <td>
                                                    <?php echo $product['attribute'][$key]; ?>
                                                </td>
                                            <?php } else { ?>
                                                <td>
                                                </td>
                                            <?php } ?>
                                        <?php } ?>
                                    </tr>
                                </tbody>
                            <?php } ?>
                        <?php } ?>
                        
                        <tr>
                            <td></td>
                            <?php foreach ($products as $product) { ?>
                                <td>
                                    <div class="compare-product-more-container">
                                        <a target="_blank" class="compare-product-more" href="<?php echo $product['href']; ?>">
                                            <?php echo $text_more; ?>
                                        </a>
                                    </div>
                                    <div class="compare-product-remove-container">
                                        <a class="compare-product-remove" href="<?php echo $product['remove']; ?>" class="btn btn-danger btn-block">
                                            <?php echo $button_remove; ?>
                                        </a>
                                    </div>
                                </td>
                            <?php } ?>
                        </tr>
                    </table>
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