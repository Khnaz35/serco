<?php echo $header; ?>
<div class="container top-block">
    <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
    <div class="row">
    <?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-xs-12 col-sm-4 col-md-6 col-lg-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-xs-12 col-sm-8 col-md-9 col-lg-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-xs-12 col-sm-12 col-md-12 col-lg-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
    <?php echo $content_top; ?>
    <h1><span><?php echo $heading_title; ?></span></h1>
    <?php if ($reviews) { ?>
      <div id="review">
<?php foreach ($reviews as $review) { ?>
<table class="review_list table table-striped table-bordered">
  <tr>
    <td style="width:30%;"><i class="fa fa-user" aria-hidden="true"></i> 
	<span><?php echo $review['author']; ?></span>
	<?php if($review['purchased']) {?><span class="purchased"><i class="fa fa-cart-plus" aria-hidden="true"></i> <?php echo $text_purchased?></span><?php } ?></td>
	<td style="width:30%;">
	<div class="rating">
	<?php for ($i = 1; $i <= 5; $i++) { ?>
      <?php if ($review['rating'] < $i) { ?>
      <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
      <?php } else { ?>
      <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
      <?php } ?>
    <?php } ?>
	</div>
	</td>
    <td class="text-right"><?php echo $review['date_added']; ?></td>
  </tr>
  <tr>
    <td colspan="3">
		<div class="comment">
			<?php echo $review['description']; ?>
		</div>
	</td>
  </tr>
</table>
<?php } ?>
        </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
<?php } else { ?>
<p><?php echo $text_empty; ?></p>
<?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>