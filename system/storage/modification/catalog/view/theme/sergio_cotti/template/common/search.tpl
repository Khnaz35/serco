
            <?php if ($live_search_ajax_status):?>
	            <link rel="stylesheet" type="text/css" href="catalog/view/theme/cybershark/stylesheet/live_search.css" />
				<script type="text/javascript"><!--
					
                    var live_search = {
						selector: '#search',
						text_no_matches: '<?php echo $text_empty; ?>',
						//height: '50px',
						delay: 400
					}

					$(document).ready(function() {
						var html = '';
						html += '<div id="live-search">';
						html += '	<ul>';
						html += '	</ul>';
						html += '<div class="result-text"></div>';
						html += '</div>';

						$(live_search.selector).after(html);
						$('#search input[name=\'search\']').autocomplete({
							'source': function(request, response) {
								if ($(live_search.selector + ' input[type=\'text\']').val() == '') {
									$('#live-search').css('display','none');
								}
								else{
									var html = '';
									html += '<li style="text-align: center;height:10px;">';
									html +=	'<img class="loading" src="catalog/view/theme/cybershark/image/loading.gif" />';
									html +=	'</li>';
									$('#live-search ul').html(html);
									$('#live-search').css('display','block');
								}
								var filter_name = $(live_search.selector + ' input[type=\'text\']').val();

								if (filter_name.length>0) {
									$.ajax({
										url: 'index.php?route=product/live_search&filter_name=' +  encodeURIComponent(request),
										dataType: 'json',
										success: function(result) {
											var products = result.products;
											$('#live-search ul li').remove();
											$('.result-text').html('');
											if (!$.isEmptyObject(products)) {
												var show_image = <?php echo $live_search_show_image;?>;
												var show_price = <?php echo $live_search_show_price;?>;
												var show_description = <?php echo $live_search_show_description;?>;
												$('.result-text').html('<a href="<?php echo $live_search_href;?>'+filter_name+'" style="display:block;"><?php echo $text_view_all_results;?> ('+result.total+')</a>');

												$.each(products, function(index,product) {
													var html = '';
													
													html += '<li>';
													html += '<a href="' + product.url + '" title="' + product.name + '">';
													if(product.image && show_image){
														html += '	<div class="product-image"><img alt="' + product.name + '" src="' + product.image + '"></div>';
													}
													html += '	<div class="product-name">' + product.name ;
													if(show_description){
														html += '<p>' + product.extra_info + '</p>';
													}
													html += '</div>';
													if(show_price){
														if (product.special) {
															html += '	<div class="product-price"><span class="special"><?php echo $text_rozn;?>' + product.special + '</span><span class="old">' + product.price + '</span><span class="price_mopt"><?php echo $text_mopt;?>' + product.mopt_price + '</span></div>';
														} else {
															html += '	<div class="product-price"><span class="price"><?php echo $text_rozn;?>' + product.price + '</span><span class="price_mopt"><?php echo $text_mopt;?>' + product.mopt_price + '</span></div>';
														}
													}
													html += '<div style="clear:both;"></div>';
													html += '</a>';
													html += '</li>';
													$('#live-search ul').append(html);
												});
											} else {
												var html = '';
												html += '<li style="text-align: center;height:10px;">';
												html +=	live_search.text_no_matches;
												html +=	'</li>';

												$('#live-search ul').html(html);
											}
											$('#live-search ul li').css('height',live_search.height);
											$('#live-search').css('display','block');
											return false;
										}
									});
								}
							},
							'select': function(product) {
								$('input[name=\'search\']').val(product.name);
							}
						});

						$(document).bind( "mouseup touchend", function(e){
						  var container = $('#live-search');
						  if (!container.is(e.target) && container.has(e.target).length === 0)
						  {
						    container.hide();
						  }
						});
                        
					});
                    

					
                    var live_search_fixed = {
						selector: '#search_fixed',
						text_no_matches: '<?php echo $text_empty; ?>',
						//height: '50px',
						delay: 400
					}
                    
					$(document).ready(function() {
						
						var html_fixed = '';
						html_fixed += '<div id="live-search_fixed">';
						html_fixed += '	<ul>';
						html_fixed += '	</ul>';
						html_fixed += '<div class="result-text_fixed"></div>';
						html_fixed += '</div>';

						$(live_search_fixed.selector).after(html_fixed);
						$('#search_fixed input[name=\'search_fixed\']').autocomplete({
							'source': function(request, response) {
								if ($(live_search_fixed.selector + ' input[type=\'text\']').val() == '') {
									$('#live-search_fixed').css('display','none');
								}
								else{
									var html = '';
									html += '<li style="text-align: center;height:10px;">';
									html +=	'<img class="loading" src="catalog/view/theme/cybershark/image/loading.gif" />';
									html +=	'</li>';
									$('#live-search_fixed ul').html(html);
									$('#live-search_fixed').css('display','block');
								}
								var filter_name = $(live_search_fixed.selector + ' input[type=\'text\']').val();

								if (filter_name.length>0) {
									$.ajax({
										url: 'index.php?route=product/live_search&filter_name=' +  encodeURIComponent(request),
										dataType: 'json',
										success: function(result) {
											var products = result.products;
											$('#live-search_fixed ul li').remove();
											$('.result-text_fixed').html('');
											if (!$.isEmptyObject(products)) {
												var show_image = <?php echo $live_search_show_image;?>;
												var show_price = <?php echo $live_search_show_price;?>;
												var show_description = <?php echo $live_search_show_description;?>;
												$('.result-text_fixed').html('<a href="<?php echo $live_search_href;?>'+filter_name+'" style="display:block;"><?php echo $text_view_all_results;?> ('+result.total+')</a>');

												$.each(products, function(index,product) {
													var html = '';
													
													html += '<li>';
													html += '<a href="' + product.url + '" title="' + product.name + '">';
													if(product.image && show_image){
														html += '	<div class="product-image"><img alt="' + product.name + '" src="' + product.image + '"></div>';
													}
													html += '	<div class="product-name">' + product.name ;
													if(show_description){
														html += '<p>' + product.extra_info + '</p>';
													}
													html += '</div>';
													if(show_price){
														if (product.special) {
															html += '	<div class="product-price"><span class="special"><?php echo $text_rozn;?>' + product.special + '</span><span class="old">' + product.price + '</span><span class="price_mopt"><?php echo $text_mopt;?>' + product.mopt_price + '</span></div>';
														} else {
															html += '	<div class="product-price"><span class="price"><?php echo $text_rozn;?>' + product.price + '</span><span class="price_mopt"><?php echo $text_mopt;?>' + product.mopt_price + '</span></div>';
														}
													}
													html += '<div style="clear:both;"></div>';
													html += '</a>';
													html += '</li>';
													$('#live-search_fixed ul').append(html);
												});
											} else {
												var html = '';
												html += '<li style="text-align: center;height:10px;">';
												html +=	live_search_fixed.text_no_matches;
												html +=	'</li>';

												$('#live-search_fixed ul').html(html);
											}
											$('#live-search_fixed ul li').css('height',live_search_fixed.height);
											$('#live-search_fixed').css('display','block');
											return false;
										}
									});
								}
							},
							'select': function(product) {
								$('input[name=\'search_fixed\']').val(product.name);
							}
						});
                        
						$(document).bind( "mouseup touchend", function(e){
						  var container = $('#live-search_fixed');
						  if (!container.is(e.target) && container.has(e.target).length === 0)
						  {
						    container.hide();
						  }
						});
					});
				//--></script>
			<?php endif;?>
            
<div id="search" class="search-fixed d-flex justify-content-center align-items-center">
    <div class="search-close d-flex justify-content-center align-items-center">
        <span></span>
    </div>
    <div class="search-holder d-flex">
        <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>"
        autocomplete="off" class="form-control form-search" />

        <button type="button" class="d-flex justify-content-center align-items-center">
            <span class="search-logo"><i class="fal fa-search"></i></span>
        </button>
    </div>
</div>