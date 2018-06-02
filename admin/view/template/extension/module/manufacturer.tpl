<!-- 
    Module Name: Manufacturers Module
    Description:  The module is developed to show manufacturers list on any page of opencart. You can set module name, you can show or hide manaufacturers image in module settings.This is very initial version of module.
    Author: Umer Khalid Cheema
    Author Email:umertoday@gmail.com
    Author URI: https://www.facebook.com/umertoday
    Version: 1.0
    Tags: Module, Manufacturers, OpenCart-->

<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-manufacturer" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-manufacturer" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-heading"><?php echo $entry_heading; ?></label>
            <div class="col-sm-10">
              <input type="text" name="manufacturer_heading" value="<?php
echo $manufacturer_heading;
?>" placeholder="<?php
echo $entry_heading;
?>" id="manufacturer_heading" class="form-control" required/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="manufacturer_image_status"><?php echo $entry_image; ?></label>
            <div class="col-sm-10">
              <select name="manufacturer_image_status" id="manufacturer_image_status" class="form-control">
                <?php if ($manufacturer_image_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div id="div_width_hight">
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image_height_width; ?></label>
              <div class="col-sm-10">
                <div class=" row">
                  <div class="col-md-6">
                    <input type="text" name="manufacturer_image_width" value="<?php
echo $manufacturer_image_width;
?>" placeholder="<?php
echo $entry_image_width;
?>" id="manufacturer_image_width" class="form-control" required/>
                  </div>
                  <div class="col-md-6">
                    <input type="text" name="manufacturer_image_height" value="<?php
echo $manufacturer_image_height;
?>" placeholder="<?php
echo $entry_image_height;
?>" id="manufacturer_image_height" class="form-control" required/>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="manufacturer_status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="manufacturer_status" id="manufacturer_status" class="form-control">
                <?php if ($manufacturer_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div><?php echo $author_creadits; ?></div>
  </div>
</div>
<script>
$(function() {
 	show_img_status = '<?php echo $manufacturer_image_status ;?>';
		if(show_img_status){
			$('#div_width_hight').show();
		}
		else{
    $('#div_width_hight').hide(); 
		}
    $('#manufacturer_image_status').change(function(){
        if($('#manufacturer_image_status').val() == '1') {
            $('#div_width_hight').show(); 
        } else {
            $('#div_width_hight').hide(); 
        } 
    });
});
</script> 
<?php echo $footer; ?>