<?php echo $header; ?>

<div class="container" itemscope itemtype="https://schema.org/Product">

    <ul class="breadcrumb" itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a itemprop="url" href="<?php echo $breadcrumb['href']; ?>"><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
    
    <div id="content" class="row">
    
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5">
        
            <div class="product-images">
                
                <?php if ($thumb) { ?>
					<div class="product-thumbnail-main <?php echo $label; ?>">
                        <div class="product-thumbnails">
                            <span class="product-thumbnail">
                                <img class="xzoom" id="main_image" src="<?php echo $thumb; ?>" xoriginal="<?php echo $popup; ?>" alt="<?php echo $heading_title; ?>" />
                            </span>
                        </div>
                    </div>
                <?php } ?>
                
                <?php if ($images) { ?>
                    <div class="product-thumbnails-container">
                      <div class="product-thumbnails xzoom-thumbs">
                        <?php $first_item = true; ?>
                        <?php foreach ($images as $image) { ?>
                            <div class="image-additional<?php if ($first_item) { $first_item = false; ?> active<?php } ?>">
                                <a class="product-item-thumbnail" href="<?php echo $image['popup']; ?>">
                                    <img class="xzoom" src="<?php echo $image['thumb']; ?>" xpreview="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" />
                                </a>
                            </div>
                        <?php } ?>
                      </div>
                    </div>
                <?php } ?>
                
                <div class="clearfix">
                </div>
                
                <script type="text/javascript">
                    $(document).ready(function() {    
                        $(".xzoom").xzoom({zoomWidth: 360, zoomHeight: 360, Xoffset: 4, Yoffset: 2, tint:'#000000', tintOpacity: 0.5, mposition:'inside',position:'inside' });
                    });
                </script>
            </div>
            
        </div><!-- <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5"> -->
        
        
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-7">
        
            <div class="row product-info-container">
            
                <?php if ($column_right) { ?>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
                <?php } else { ?>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <?php } ?>
            
            
                    <?php if ($content_top) { ?>
                        <div id="content-top">
                            <?php echo $content_top; ?>
                        </div>
                    <?php } ?>
                    
                    <h1 itemprop="name"><?php echo $heading_title; ?></h1>
                
                
                    <div id="product">
                    
						<?php if ($rating) { ?>
							<span itemscope itemprop="aggregateRating" itemtype="http://schema.org/AggregateRating">
								<meta itemprop="reviewCount" content="<?php echo $reviewCount; ?>">
								<meta itemprop="ratingValue" content="<?php echo $ratingValue; ?>">
								<meta itemprop="bestRating" content="5"><meta itemprop="worstRating" content="1">
							</span>
						<?php } ?>
                        <span itemprop="brand" class="hidden">Sergio Cotti</span>
                    
                        <div class="product-attrs-container">
                            <?php if ($model) { ?>
                           <!--    <div class="attr_container">
                                    <span class="attr_title"><?php echo $text_model; ?></span> <span itemprop="model"><?php echo $model; ?></span>
                                </div>  -->
                            <?php } ?>
                            
                            <?php if ($sku) { ?>
                                <div class="attr_container">
                                    <span class="attr_title"><?php echo $text_sku; ?></span> <span itemprop="model"><?php echo $sku; ?></span>
                                </div>
                            <?php } ?>
                            
                            <?php if ($minimum > 1) { ?>
                                <div class="attr_container product-minimum">
                                    <?php echo $text_minimum; ?>
                                </div>
                            <?php } ?>
                                            
                            <?php if ($points) { ?>
                                <div class="attr_container product-points">
                                    <span class="attr_title"><?php echo $text_points; ?></span> <?php echo $points; ?>
                                </div>
                            <?php } ?>                    
                                            
                            <?php if ($reward) { ?>
                                <div class="attr_container reward_container">
                                    <span class="attr_title"><?php echo $text_reward; ?></span> <?php echo $reward; ?>
                                </div>
                            <?php } ?>
                                            
                            <?php if ($discounts) { ?>
                                <?php foreach ($discounts as $discount) { ?>
                                    <div class="attr_container product-discounts">
                                        <span class="attr_title"><?php echo $discount['quantity']; ?><?php echo $text_discount; ?></span> <?php echo $discount['price']; ?>
                                    </div>
                                <?php } ?>
                            <?php } ?>
                                                        
                            <?php if ($attribute_groups) { ?>
                                <div class="product-attrs-groups">
                                    <?php foreach ($attribute_groups as $attribute_group) { ?>
                                        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                            <div id="attr_container-<?php echo $attribute['attribute_id']; ?>" class="attr_container">
                                                <span class="attr_title"><?php echo $attribute['name']; ?>:</span> <?php echo $attribute['text']; ?>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                </div>
                            <?php } ?>
                        </div>
                        
                        
                        <?php if ($options) { ?>
                            <?php foreach ($options as $option) { ?>
                                        <?php if ($option['type'] == 'select') { ?>
                                            <div class="option-container option-select-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                        <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                    </div>
                                                    <div class="option_body_container">
                                                        <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control option-control">
                                                        
                                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                                    <?php if ($option_value['price']) { ?>
                                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                    <?php } ?>
                                                                </option>
                                                            <?php } ?>
                                                      </select>
                                                    </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        
                                        <?php if ($option['type'] == 'radio') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                        <label class="option_title control-label"><?php echo $option['name']; ?>:</label>
                                                    </div>
                                                    <div class="option_body_container">
                                                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                            <?php $radio_first = true; ?>
                                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                                
                                                                <?php if ($option_value['quantity'] > 0) { ?>
                                                                    <div class="radio">
                                                                        <label class="<?php if ($radio_first) { echo('radio-checked'); } ?> <?php if ($option_value['quantity'] < 1) { echo('radio-empty'); } ?>">
                                                                            <input <?php if ($radio_first) { echo('checked'); $radio_first = false; } ?> type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                            <?php echo $option_value['name']; ?>
                                                                            <?php if ($option_value['price']) { ?>
                                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                            <?php } ?>
                                                                        </label>
                                                                    </div>
                                                                <?php } else { ?>
                                                                    <div class="radio">
                                                                        <label class="<?php if ($option_value['quantity'] < 1) { echo('radio-empty'); } ?>">
                                                                            <?php echo $option_value['name']; ?>
                                                                            <?php if ($option_value['price']) { ?>
                                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                            <?php } ?>
                                                                        </label>
                                                                    </div>
                                                                <?php } ?>
                                                                
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
                                            $(document).ready(function(){
                                                $("#input-option<?php echo $option['product_option_id']; ?> .radio label").click(function(){
                                                    if (!$(this).hasClass('radio-empty')) {
                                                        $("#input-option<?php echo $option['product_option_id']; ?> .radio label").removeClass('radio-checked');
                                                        $(this).addClass('radio-checked');
                                                    }
                                                });
                                            });
                                            </script>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'checkbox') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                        <label class="option_title control-label"><?php echo $option['name']; ?>:</label>
                                                    </div>
                                                    <div class="option_body_container">
                                                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                            <div class="checkbox">
                                                                <label>
                                                                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                    <?php echo $option_value['name']; ?>
                                                                    <?php if ($option_value['price']) { ?>
                                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                    <?php } ?>
                                                                </label>
                                                            </div>
                                                        <?php } ?>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'text') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                        <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                                                    </div>
                                                    <div class="option_body_container">
                                                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="a_input_text form-control" />
                                                    </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'textarea') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                                                </div>
                                                    <div class="option_body_container">
                                                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                                            </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'date') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                                                </div>
                                                    <div class="option_body_container">
                                                <div class="input-group date">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="a_input_text form-control" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                                </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'datetime') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                                                </div>
                                                    <div class="option_body_container">
                                                <div class="input-group datetime">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="a_input_text form-control" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                                </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                            
                                        <?php if ($option['type'] == 'time') { ?>
                                            <div class="option-container option-container-<?php echo $option['product_option_id']; ?> form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <div class="product_option_container">
                                                    <div class="option_title_container">
                                                <label class="option_title control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                                                </div>
                                                    <div class="option_body_container">
                                                <div class="input-group time">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="a_input_text form-control" />
                                                        <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                                </div>
                                                    <div class="clearfix">
                                                    </div>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        
                            <?php } ?>
                        <?php } ?><!-- options -->
                        
                        
                        <div class="product-sizes-container">
                            <a class="table-size-link" href="<?php echo $dimentions_table; ?>"><?php echo $text_dimentions_table; ?></a>
                            <script type="text/javascript">
                            $(document).delegate('.table-size-link', 'click', function(e) {
                            	e.preventDefault();
                            
                            	$('#modal-table-size').remove();
                            
                            	var element = this;
                            
                            	$.ajax({
                            		url: $(element).attr('href'),
                            		type: 'get',
                            		dataType: 'html',
                            		success: function(data) {
                            			html  = '<div id="modal-table-size" class="modal">';
                            			html += '  <div class="modal-dialog">';
                            			html += '    <div class="modal-content">';
                            			html += '      <div class="modal-header">';
                            			html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
                            			html += '        <div class="modal-title">' + $(element).text() + '</div>';
                            			html += '      </div>';
                            			html += '      <div class="modal-body">' + data + '</div>';
                            			html += '    </div';
                            			html += '  </div>';
                            			html += '</div>';
                            
                            			$('body').append(html);
                            
                            			$('#modal-table-size').modal('show');
                            		}
                            	});
                            
                            });
                            </script>
                        </div>
                        
                        <div class="product-colors-container">
                           <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <div class="product-colors-list">
                                       <?php  if( isset($product_color) && isset($relative_products_color)  ){ ?>
                                            <div class="product-colors-list-title">
                                                        Доступные Цвета
                                            </div>
                                                <?php } ?>  
                                            
                                            <ul class="product_colors">
                                               <?php  if(isset($product_color)){
                                               foreach ($product_color as $color) { ?>
                                                        <li class="product_color_selected">
                                                            <div class="product_color_selected_container">
                                                                <img src="image/<?php echo $color['color_image']; ?>" title="<?php echo $color['name']; ?>" alt="<?php echo $color['name']; ?>" />
                                                            </div>
                                                        </li>
                                                        <?php }} ?>
                                                        
                                                     <?php  if(isset($relative_products_color)){
                                                     foreach ($relative_products_color as $color) { ?>    
                                                    
                                           
                                                        <li class="product_color_not_selected">
                                                            <div class="product_color_not_selected_container">
                                                                <a href="<?php echo $color['link']; ?>">
                                                                    <img src="<?php echo $color['color_image']; ?>" title="<?php echo $color['name']; ?>" alt="<?php echo $color['name']; ?>" />
                                                                </a>
                                                            </div>
                                                        </li>
                                        
                                               <?php }} ?>
                                            </ul>
                                            
                                            <div class="clearfix">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                            
                            
                            
                        </div>
                        
                        
                        <?php if ($price) { ?>
                        
        					<span class="hidden" itemscope itemprop="offers" itemtype="http://schema.org/Offer">
        						<meta itemprop="price" content="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($special ? $special : $price)), '.'); ?>">
        						<meta itemprop="priceCurrency" content="<?php echo $currency_microdata; ?>">
                                <link itemprop="availability" href="https://schema.org/<?php echo $meta_stock; ?>" />
                            </span>
                            
                            <div class="product-info-price-container">
                                <div class="product-info-price-title">
                                    Цена:
                                </div>
                                <div class="product-info-price-body">
                                    <div class="product-info-prices">
                                    
                                            <div class="price-roz">
                                                <div class="price-title">
                                                    <?php echo $text_rozn; ?>
                                                </div>
                                                <div class="price-body">
                                                    <?php if (!$special) { ?>
                                                        <div class="price-regular">
                                                            <?php echo $price; ?>
                                                        </div>
                                                    <?php } else { ?>
                                                        <div class="price-new">
                                                            <?php echo $special; ?>
                                                        </div>
                                                        <?php /*<div class="price-old">
                                                            <?php echo $price; ?>
                                                        </div>*/ ?>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        
                                    <!--<div class="price-mopt">
                                                <div class="price-title">
                                                    <?php echo $text_mopt; ?>
                                                </div>
                                                <div class="price-body">
                                                    <?php echo $mopt_price; ?>
                                                </div>
                                            </div>  -->
                                            
                                            <div class="price-opt">
                                                <div class="price-title">
                                                    <?php echo $text_opt; ?>
                                                </div>
                                                <div class="price-body">
                                                    <a href="#get-price" onclick="get_price_open('<?php echo $product_id; ?>'); return false;"><?php echo $text_known; ?></a>
                                                </div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        <?php } ?>
                    
                        <?php if ($quantity > 0) { ?>
                            <div class="product-quantity">
                                <div class="product-quantity-minus">
                                -
                                </div>
                                
                                <div class="product-quantity-input">
                                    <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control noletters" />
                                </div>
                                
                                <div class="product-quantity-plus">
                                +
                                </div>
                                
                                <div class="product-quantity-minimum hidden">
                                <?php echo $minimum; ?>
                                </div>
                                
                                <div class="clearfix">
                                </div>
                            </div>
                        <?php } ?>
                        
                        <?php if ($quantity > 0) { ?>
                            <div class="product-btn-buy">
                                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                             
                                 <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block"><?php echo $button_cart; ?></button> 
                                <div class="clearfix">
                                </div>
                            </div>
                        <?php } else { ?>
                            <?php if ($stock == 'Предзаказ') { ?>
                                <button class="btn-quick-order btn-lg btn-block" type="button" onclick="fastorder_open(<?php echo $product_id?>);" title="<?php echo $button_preorder; ?>"><?php echo $button_preorder; ?></button>
                            
                                <div class="clearfix">
                                </div>
                            <?php } ?>
                        <?php } ?>
                        
                        <div class="product-btns">
                            <button type="button" class="btn-wishlist" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-bookmark-o" aria-hidden="true"></i> <span><?php echo $button_wishlist; ?></span></button>
                            <button type="button" class="btn-compare" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-bar-chart" aria-hidden="true"></i> <span><?php echo $button_compare; ?></span></button>
                        </div>
                        
                        <div class="product-share">
                            <div class="product-share-title">
                                <?php echo $text_share; ?>
                            </div> 
                            <div class="share42init"></div> 
                        </div>
                        
                    </div><!-- <div id="product"> -->
                    
                </div><!-- <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8"> -->
            
                <?php if ($column_right) { ?>
                    <div class="hidden-xs hidden-sm hidden-md col-lg-4 product-payment-delivery">
                        <div class="product-payment-delivery-container">
                            <?php echo $column_right; ?>
                        </div>
                    </div>
                <?php } ?>
                
            </div><!-- <div class="product-info-container"> -->
            
        </div><!-- <div class="col-xs-12 col-sm-12 col-md-6 col-lg-7"> -->

    </div><!-- <div id="content" class="row"> -->
    
    
    <?php if ($column_right) { ?>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 hidden-lg product-payment-delivery">
                <div class="product-payment-delivery-container">
                    <?php echo $column_right; ?>
                </div>
            </div>
        </div>
    <?php } ?>
                
    <div id="product-nav-container">
            <ul class="nav nav-tabs">
                
                <?php if ($attribute_groups) { ?>
                    <li class="active"><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
                    <li><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
                <?php } else { ?>
                    <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
                <?php } ?>
                
                <?php if ($review_status) { ?>
                    <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
                <?php } ?>
                
                <?php if ($column_left) { ?>
                    <li><a href="#tab-return" data-toggle="tab"><?php echo $tab_return; ?></a></li>
                <?php } ?>
            </ul>
    </div><!-- <div id="product-nav" class="row"> -->
    
    
    <div id="product-tabs-container" class="tab-content">
        
        <?php if ($attribute_groups) { ?>
            <div class="tab-pane active" id="tab-specification">
                <table class="table table-bordered">
                    <?php foreach ($attribute_groups as $attribute_group) { ?>
                        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                            <tr>
                                <td><?php echo $attribute['name']; ?></td>
                                <td><?php echo $attribute['text']; ?></td>
                            </tr>
                        <?php } ?>
                    <?php } ?>
                </table>
            </div>
        <div class="tab-pane" id="tab-description" itemprop="description">
        <?php } else { ?>
        <div class="tab-pane active" id="tab-description" itemprop="description">
        <?php } ?>
            <?php echo $description; ?>
        </div>
        
        <?php if ($column_left) { ?>
            <div class="tab-pane" id="tab-return">
                <?php echo $column_left; ?>
            </div>
        <?php } ?>
            
        <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
                
                <div id="review"></div>
                    
                <form class="form-horizontal" id="form-review">
                    
                    <div class="review-title">
                        <?php echo $text_write; ?>
                    </div>
                            
                    <?php if ($review_guest) { ?>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label"><?php echo $entry_rating; ?></label>
                                    <div class="review_rating_stars">
                                        <ul>
                                            <li>
                                                <a id="review_rating_star_1" class="" href="#1"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_2" class="" href="#2"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_3" class="" href="#3"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_4" class="" href="#4"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_5" class="" href="#5"></a>
                                            </li>
                                        </ul>
                                    </div>
                                <input name="rating" value="0" type="hidden">
                            </div>
                        </div>
                        
                        <div class="buttons clearfix">
                            <div class="pull-left">
                                <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                            </div>
                        </div>
                    <?php } else { ?>
                        <?php echo $text_login; ?>
                    <?php } ?>
                </form>
            </div>
        <?php } ?>
    </div>
    
    
    <?php if ($tags) { ?>
        <div id="product-tags-container" class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="product-tags">
                    <?php foreach ($tags as $tag) { ?>
                        <a href="<?php echo $tag['href']; ?>"><?php echo($tag['tag']); ?></a>
                    <?php } ?>
                </div>
            </div>
        </div><!-- <div id="product-tags-container" class="row"> -->
    <?php } ?>
    
    
    <?php if ($products) { ?>
        <div class="container-module container-product-carousel container-related">
            <div class="title-module">
                <span><?php echo $text_related; ?></span>
            </div>
            
            <div class="product-slider">
                <div class="container-modules related carousel_numb_product_related owl-carousel">
                    <?php foreach ($products as $product) { ?>			
                        <div class="item">
							<div class="product-layout product-grid <?php echo $product['label']; ?>">
                                <div class="product-thumb-outer">
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
                            
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function(){
          
                $(".carousel_numb_product_related").owlCarousel({
                    margin:0,
                    nav:true,
                    dots:false,
                    navText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
                    responsiveClass:true,
                    responsive:{
                        0:{
                            items:1
                        },
                        767:{
                            items:2
                        },
                        990:{
                            items:3
                        },
                        1200:{
                            items:4
                        }
                    }
                });
            });
        </script>
    <?php } ?><!-- if $products -->
    
    
    <?php if ($content_bottom) { ?>
        <div id="content-bottom">
            <?php echo $content_bottom; ?>
        </div>
    <?php } ?>
    
<?php echo $galery_diplom; ?>


</div><!-- <div class="container"> -->



<script type="text/javascript"><!--
/*$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});*/
//--></script>
<script type="text/javascript">
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
                 $('#button-cart').button('loading');     
                },
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('#content').parent().before('<div id="modal-addcart" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">' + json['success'] + '</div></div><div class="modal-body"><div class="text-center"><img style="margin:10px 0px;" src="'+ json['image_cart'] +'"  /><br></div><div class="text-center"><div class="popup-name">' + json['success_name'] + '</div><br></div><div class="text-center"><div class="popup-btn-left"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="popup-btn-right"><a href=' + link_checkout + ' class="btn btn-primary">'+ button_checkout +'</a></div><div class="clearfix"></div></div></div>	</div></div></div>');
				$('#modal-addcart').modal('show');  
            
				setTimeout(function () {
					$('#cart').load('index.php?route=common/cart/info');
					$('#cart_fixed').load('index.php?route=common/cart_fixed/info')
				}, 100);

			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});
</script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#content').parent().before('<div id="modal-warning" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Внимание!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['error'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
				$('#modal-warning').modal('show');
			}

			if (json['success']) {
				$('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Успех!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['success'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
				$('#modal-success').modal('show');
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
    grecaptcha.reset();
});

/*(document).ready(function() {
    $.extend(true, $.magnificPopup.defaults, {
      tClose: 'Закрыть (Esc)', // Alt text on close button
      tLoading: 'Загрузка...', // Text that is displayed during loading. Can contain %curr% and %total% keys
      gallery: {
        tPrev: 'Назад', // Alt text on left arrow
        tNext: 'Далее', // Alt text on right arrow
        tCounter: '%curr% из %total%' // Markup for "1 of 7" counter
      },
      image: {
        tError: '<a href="%url%">Изображение</a> не можеть быть загружено.' // Error message when image could not be loaded
      },
      ajax: {
        tError: '<a href="%url%">Содержимое</a> не можеть быть загружено.' // Error message when ajax request failed
      }
    });
    
	$('.product-thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});*/

$(document).ready(function() {
	var hash = window.location.hash;
	if (hash) {
		var hashpart = hash.split('#');
		var  vals = hashpart[1].split('-');
		for (i=0; i<vals.length; i++) {
			$('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
			$('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
		}
	}
})
//--></script>
<?php echo $footer; ?>