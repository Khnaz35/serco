<div class="container-module container-reviews">
    <?php $gen_reviews = rand(10000, 50000);?>
    <?php if ($module_header) { ?>
        <div class="title-module">
            <span><?php echo $module_header; ?></span>
        </div>
    <?php } ?>	
	<div class="product-slider">
		<div class="container-modules reviews carousel_reviews<?php echo $gen_reviews;?> owl-carousel">
			<?php foreach ($reviews as $review) { ?>
			<div class="item">
				<div class="product-thumb transition">
					<div class="image">
						<a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>" class="img-responsive" /></a>
					</div>
					<div class="caption">
					 <div class="product-name"><a href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a></div>
						<div class="product-description"><?php echo $review['description']; ?></div>
						<div class="rating">
							<span class="rating-box">
								<?php for ($i = 1; $i <= 5; $i++) { ?>
									<?php if ($review['rating'] < $i) { ?>
									<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<?php } else { ?>
									<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
									<?php } ?>
								<?php } ?>
							</span>
										
											  <?php if($ns_on_off_featured_quantity_reviews !='0') { ?>
												<span class="quantity-reviews"><a data-placement="right"  data-toggle="tooltip" title="<?php echo $text_reviews_title;?>" href="<?php echo $review['href']; ?>/#tab-review"><?php echo $review['reviews']; ?></a></span>
											 <?php } ?>
						</div>
						<div class="reviews-sign row">
							<div class="reviews-date col-xs-6 text-left"><?php echo $review['date_added']; ?></div>
                            <div class="reviews-author col-xs-6 text-right"><?php echo $review['author']; ?></div>
						</div>
				   <?php if ($show_all_button) { ?>
					<div class="button-more">
						<button class="btn btn-more" type="button" onclick="window.location.href='<?php echo $link_all_reviews; ?>'"><?php echo $text_all_reviews ?></button>
					</div>
				<?php } ?>
					</div>
				</div>
			</div>
			<?php } ?>	
		</div>
	</div>
<script type="text/javascript">
$('.carousel_reviews<?php echo $gen_reviews;?>').owlCarousel({
	responsiveBaseWidth: ".carousel_reviews<?php echo $gen_reviews;?>",
	itemsCustom: [[0, 1], [360, 1], [500, 2], [678, 4], [990, 4], [1000,5]],
	slideSpeed: 200,
	paginationSpeed: 300,
	navigation: true,
	stopOnHover: true,		
	mouseDrag: true,
	touchDrag: true,
	pagination: false,
	autoPlay: false,
	navigationText: ['<div class="btn btn-carousel-module next-prod"><i class="fa fa-angle-left arrow"></i></div>', '<div class="btn btn-carousel-module prev-prod"><i class="fa fa-angle-right arrow"></i></div>'],	
});
</script>
</div>


