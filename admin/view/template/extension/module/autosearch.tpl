<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-featured" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_on_off_autosearch; ?></label>
				<div class="col-sm-10">
				  <select name="autosearch_on_off" id="input-status" class="form-control">
					<?php if ($autosearch_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_search_model"><?php echo $text_search_model; ?></label>
				<div class="col-sm-10">
				  <select name="search_model_on_off" id="text_search_model" class="form-control">
					<?php if ($search_model_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_search_tag"><?php echo $text_search_tag; ?></label>
				<div class="col-sm-10">
				  <select name="search_tag_on_off" id="text_search_tag" class="form-control">
					<?php if ($search_tag_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_search_manufacturer"><?php echo $text_search_manufacturer; ?></label>
				<div class="col-sm-10">
				  <select name="search_manufacturer_on_off" id="text_search_manufacturer" class="form-control">
					<?php if ($search_manufacturer_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_search_upc"><?php echo $text_search_upc; ?></label>
				<div class="col-sm-10">
				  <select name="search_upc_on_off" id="text_search_upc" class="form-control">
					<?php if ($search_upc_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_search_sku"><?php echo $text_search_sku; ?></label>
				<div class="col-sm-10">
				  <select name="search_sku_on_off" id="text_search_sku" class="form-control">
					<?php if ($search_sku_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_image"><?php echo $text_display_image; ?></label>
				<div class="col-sm-10">
				  <select name="display_image_on_off" id="text_display_image" class="form-control">
					<?php if ($display_image_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<?php if(empty($image_search_width)) $image_search_width = "50";?>
			<?php if(empty($image_search_height)) $image_search_height = "50";?>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="entry_width"><?php echo $entry_width; ?></label>
				<div class="col-sm-4">
					<input type="text" name="image_search_width" class="form-control" value="<?php echo $image_search_width;?>" />
				</div>
				<label class="col-sm-2 control-label" for="entry_height"><?php echo $entry_height; ?></label>
				<div class="col-sm-4">
				<input type="text" name="image_search_height" class="form-control" value="<?php echo $image_search_height;?>" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_model"><?php echo $text_display_model; ?></label>
				<div class="col-sm-10">
				  <select name="display_model_on_off" id="text_display_model" class="form-control">
					<?php if ($display_model_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_manufacturer"><?php echo $text_display_manufacturer; ?></label>
				<div class="col-sm-10">
				  <select name="display_manufacturer_on_off" id="text_display_manufacturer" class="form-control">
					<?php if ($display_manufacturer_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_price"><?php echo $text_display_price; ?></label>
				<div class="col-sm-10">
				  <select name="display_price_on_off" id="text_display_price" class="form-control">
					<?php if ($display_price_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_rating"><?php echo $text_display_rating; ?></label>
				<div class="col-sm-10">
				  <select name="display_rating_on_off" id="text_display_rating" class="form-control">
					<?php if ($display_rating_on_off) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="text_display_stock"><?php echo $text_display_stock; ?></label>
				<div class="col-sm-10">
				  <select name="display_stock_on_off" id="text_display_stock" class="form-control">
					<?php if ($display_stock_on_off) { ?>
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
  </div>
</div>
<?php echo $footer; ?>