<div class="list-group">
<span class="list-group-item active"><?php echo $manufacturer_heading; ?></span>
  <?php foreach ($manufacturers as $manufacturer) {
   
  
   ?>
  <a href="<?php echo $manufacturer['href']; ?>" class="list-group-item">
  <?php if($manufacturer_image_status == 1) { ?>
  <img src="<?php echo $manufacturer['image']; ?>" width="<?php echo $manufacturer_image_width; ?>" height="<?php echo $manufacturer_image_height; ?>">
  
  <?php } ?>
  
  <?php echo $manufacturer['name']; ?></a>
  <?php } ?>
</div>
