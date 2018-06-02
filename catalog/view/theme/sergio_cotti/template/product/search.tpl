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
            
            <div id="search-form-container">
              <label class="control-label" for="input-search"><?php echo $entry_search; ?></label>
              <div class="row">
                <div class="col-sm-12">
                  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
                </div>
                <div class="col-sm-12">
                  <select name="category_id" class="form-control">
                    <option value="0"><?php echo $text_category; ?></option>
                    <?php foreach ($categories as $category_1) { ?>
                    <?php if ($category_1['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                    <?php } ?>
                    <?php foreach ($category_1['children'] as $category_2) { ?>
                    <?php if ($category_2['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                    <?php } ?>
                    <?php foreach ($category_2['children'] as $category_3) { ?>
                    <?php if ($category_3['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
                <div class="col-sm-12">
                  <label class="checkbox-inline">
                    <?php if ($sub_category) { ?>
                    <input type="checkbox" name="sub_category" value="1" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="sub_category" value="1" />
                    <?php } ?>
                    <?php echo $text_sub_category; ?></label>
                </div>
              </div>
              <p>
                <label class="checkbox-inline">
                  <?php if ($description) { ?>
                  <input type="checkbox" name="description" value="1" id="description" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="description" value="1" id="description" />
                  <?php } ?>
                  <?php echo $entry_description; ?></label>
              </p>
              <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
                  
            </div>
      
      
      <h2><?php echo $text_search; ?></h2>
      
      
            <?php if ($products) { ?>
                <div class="limit-sort-container">
                    <div class="row">
                    
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="sort-container-wrapper">
                                <div class="sort-container">
                                    <label id="sort-text" class="control-label" for="input-sort">
                                        <?php echo $text_sort; ?>
                                    </label>
                                    <div id="sort-container-selected" onclick="openSortContainer();">
                                        <?php foreach ($sorts as $sort2) { ?>
                                            <?php if ($sort2['value'] == $sort . '-' . $order) { ?>
                                                <span><?php echo $sort2['text']; ?> <i class="fa fa-angle-down" aria-hidden="true"></i></span>
                                            <?php } ?>
                                        <?php } ?>
                                        <div id="sort-container">
                                            <ul>
                                                <?php foreach ($sorts as $sort2) { ?>
                                                    <li>
                                                        <?php if ($sort2['value'] == $sort . '-' . $order) { ?>
                                                            <span href="<?php echo $sort2['href']; ?>"><span><?php echo $sort2['text']; ?></span></span>
                                                        <?php } else { ?>
                                                            <a href="<?php echo $sort2['href']; ?>"><span><?php echo $sort2['text']; ?></span></a>
                                                        <?php } ?>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                        </div> 
                                    </div> 
                                </div>  
                            </div> 
                        </div> 
                    
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="limit-container-wrapper">
                                <div class="limit-container">
                                    <label id="limit-text" class="control-label" for="input-limit">
                                        <?php echo $text_limit; ?>
                                    </label>
                                    <div id="limit-container-selected" onclick="openLimitContainer();">
                                        <?php foreach ($limits as $limit2) { ?>
                                            <?php if ($limit2['value'] == $limit) { ?>
                                                <span><?php echo $limit2['text']; ?> <i class="fa fa-angle-down" aria-hidden="true"></i></span>
                                            <?php } ?>
                                        <?php } ?>
                                        <div id="limit-container">
                                            <ul>
                                                <?php foreach ($limits as $limit2) { ?>
                                                    <li>
                                                        <?php if ($limit2['value'] == $limit) { ?>
                                                            <span href="<?php echo $limit2['href']; ?>"><span><?php echo $limit2['text']; ?></span></span>
                                                        <?php } else { ?>
                                                            <a href="<?php echo $limit2['href']; ?>"><span><?php echo $limit2['text']; ?></span></a>
                                                        <?php } ?>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                        </div> 
                                    </div> 
                                </div>  
                            </div> 
                        </div> 
                        
                    </div> 
                </div> 
              
              
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
                
                <div class="pagination-results">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-left">
                            <?php echo $pagination; ?>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-right">
                            <div class="results">
                                <?php echo $results; ?>
                            </div>
                        </div>
                    </div>
                </div>
                
            <?php } ?>


            <?php if (!$products) { ?>
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