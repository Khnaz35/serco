<div class="categorywall-container categorywall-<?php echo $module; ?> no-touch">	
<?php if(!empty($heading_title[$lang_id]['title_name'])) { ?>
<div class="title-module"><span><?php echo $heading_title[$lang_id]['title_name'];?></span></div>
<?php } ?>
	<div class="cat-wall">
      <?php foreach ($categories as $category) { ?>
	  <div class="item">
		  <div class="item-id-<?php echo $category['category_id']; ?>"> 
				<div class="item-parent <?php if ($category['children']) { ?>i-toggle<?php } ?>">
					<a href="<?php echo $category['href']; ?>" >
						<div class="sc-image"><img src="<?php echo $category['image']; ?>" alt="<?php echo $category['name']; ?>"></div>
						<div class="sc-name"><div class="display-table"><div class="display-table-cell"><?php echo $category['name']; ?></div></div></div>
					</a>
				</div>
			<?php if ($category['children']) { ?>
			<div class="sc-grid-view">
			  <div class="well">
				<div class="wall-title"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></div>
				<div class="wall-descr"><?php echo $category['description']; ?></div>
				<?php foreach ($category['children'] as $child) { ?>
				<div class="item-id-<?php echo $child['category_id']; ?> wall_child">
					<div class="item-sub">
						<a href="<?php echo $child['href']; ?>">
							<div class="sc-image"><img src="<?php echo $child['image']; ?>" alt="<?php echo $child['name']; ?>"></div>
							<div class="sc-name"><div class="display-table"><div class="display-table-cell"><?php echo $child['name']; ?></div></div></div>
						</a>
					</div>
				</div>
				<?php } ?>
			  </div>
			</div>
			<?php } ?>
		  </div>
      </div>
      <?php } ?>
	   <?php foreach ($manufacturers as $manufacturer) { ?>
			<div class="item">
				<div class="item-id-<?php echo $manufacturer['manufacturer_id']; ?>"> 
					<div class="item-parent">
						<a href="<?php echo $manufacturer['href']; ?>" >
							<div class="sc-image"><img src="<?php echo $manufacturer['thumb']; ?>" alt="<?php echo $manufacturer['name']; ?>"></div>
							<div class="sc-name"><div class="display-table"><div class="display-table-cell"><?php echo $manufacturer['name']; ?></div></div></div>
						</a>
					</div>
				</div>
			</div>
      <?php } ?>
    </div>
</div>	
<script type="text/javascript">
$('.categorywall-<?php echo $module; ?> div.cat-wall').each(function() {
    var items = $(this).children('div');
	for (var i = 0; i < items.length; i+=<?php echo $limit_column?>) {
      items.slice(i, i+<?php echo $limit_column?>).wrapAll('<div class="sc-items-row wall-carousel owl-carousel"></div>');
    }  
  });
  $('.categorywall-<?php echo $module; ?> div.cat-wall div.sc-grid-view').each(function() {
		var items = $(this).find('>div').children('.wall_child');
		items.css('width',(100/<?php echo $limit_column_child; ?>)-1 + '%');
		for (var i = 0; i < items.length; i+=<?php echo $limit_column_child; ?>) {
		  items.slice(i, i+<?php echo $limit_column_child; ?>).wrapAll('<div class="row sc-items-row"></div>');
		}
  });
  $('.categorywall-<?php echo $module; ?> .sc-items-row').each(function() {
    $(this).after('<div class="sc-sub-row"></div>');
  });
  $('.categorywall-<?php echo $module; ?> .i-toggle').each(function(i) {
    $(this).addClass('sc-sublink-'+(i+1));
    $(this).next().addClass('sc-subcont-'+(i+1));

    $('.categorywall-<?php echo $module; ?> .sc-sublink-'+(i+1)).each(function() {
      var sub = $(this).next().not('.sc-list');
      $(this).closest('.sc-items-row').next().append(sub);
    });
        $('.categorywall-<?php echo $module; ?> .sc-sublink-'+(i+1)).click(function() {
          $(this).closest('.sc-items-row').next().find('.sc-subcont-'+(i+1)).toggleClass('open').animate({'opacity': 'toggle', 'height': 'toggle'}, 350).parent().find('div.sc-grid-view.open').not('.sc-subcont-'+(i+1)).removeClass('open').animate({'opacity': 'toggle', 'height': 'toggle'}, 350);      
          $(this).closest('.sc-items-row').next().siblings().find('div.sc-grid-view.open').removeClass('open').animate({'opacity': 'toggle', 'height': 'toggle'}, 350);
          $(this).toggleClass('sc-active').closest('div').find('.sc-active').not(this).toggleClass('sc-active');
          return false;
        });

  });
  $('.categorywall-<?php echo $module; ?> .wall-carousel').owlCarousel({
	responsiveBaseWidth: ".categorywall-<?php echo $module; ?> .wall-carousel",
	itemsCustom: [[120, 1], [400, 2], [500, 2], [630, 3], [750, 3], [900,4], [1000, 4]],
	navigation: true,
	navigationText: ['<div class="btn-carousel featured-btn-next next-prod"><i class="fa fa-angle-left arrow"></i></div>', '<div class="btn-carousel featured-btn-prev prev-prod"><i class="fa fa-angle-right arrow"></i></div>'],
	pagination: false
}); 

</script>