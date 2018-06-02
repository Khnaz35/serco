<link href="catalog/view/theme/default/stylesheet/category_collapse.css" rel="stylesheet">
<div class="list-group" id="categories-collapse">
	<div class="accordion" id="accordion2">
		<?php $i = 1; foreach ($categories as $key => $category) { ?>
			<div class="accordion-group">
				<?php 
				if($key == '0') {
					$first_class = 'first_class';
				}else{
					$first_class = '';
				}
				
				if($i == count($categories)) {
					$last_class = 'last_class';
				}else{
					$last_class = '';
				}
				
				if ($category['category_id'] == $category_id) { 
					$collapsed_class = '';
					$collapse_class = 'in';
				}else{
					$collapsed_class = 'collapsed';
					$collapse_class = '';
				}				
				?>
				
				<?php if ($category['children']) { ?>
				<div class="accordion-heading">
					<div class="accordion-toggle <?php echo $collapsed_class; ?>" data-toggle="collapse" data-parent="#accordion2" href="#category<?php echo $category['category_id']; ?>">
							<a href="<?php echo $category['href']; ?>" class="list-group-item <?php echo $first_class; ?> <?php echo $last_class; ?>"><?php echo $category['name']; ?></a>
					</div>
				</div>
				<?php }else{ ?>
				<div class="accordion-heading">
					<div class="accordion-not-toggle <?php echo $collapsed_class; ?>">
						<a href="<?php echo $category['href']; ?>" class="list-group-item <?php echo $first_class; ?> <?php echo $last_class; ?>"><?php echo $category['name']; ?></a>
					</div>
				</div>
				<?php } ?>
				<?php if ($category['children']) { ?>
				<div id="category<?php echo $category['category_id']; ?>" class="accordion-body collapse <?php echo $collapse_class; ?>">
					<div class="accordion-inner">
						<?php foreach ($category['children'] as $child) { ?>
						<?php if ($child['category_id'] == $child_id) { ?>
						<a href="<?php echo $child['href']; ?>" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
						<?php } else { ?>
						<a href="<?php echo $child['href']; ?>" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
						<?php } ?>
						<?php } ?>
					</div>
				</div>
				<?php } ?>
			</div>
			<?php $i++; } ?>
	</div>
</div>
<script type="text/javascript"><!--
var $myGroup = $('#accordion2');
$myGroup.on('show.bs.collapse','.collapse', function() {
    $myGroup.find('.collapse.in').collapse('hide');
});
//--></script>
<script>
$('[data-toggle="collapse"]').dblclick(function(e) {
   
});
</script>