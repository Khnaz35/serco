<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-privat24_fe" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-privat24_fe" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-fee">
				<span data-toggle="tooltip" title="<?php echo $entry_fee_help; ?>"><?php echo $entry_fee; ?></span></label>
            <div class="col-sm-10">
				<input type="text" name="privat24_fee_fee" value="<?php echo $privat24_fee_fee; ?>" placeholder="<?php echo $entry_fee; ?>" id="input-fee" class="form-control" />
				<div class="checkbox">
                    <label>
						<input type="checkbox" name="privat24_fee_percents" id="privat24_fee_percents" value="<?php echo $privat24_fee_percents; ?>" onclick="$(this).attr('checked') ? $('#privat24_fee_percents').val('1') : $('#privat24_fee_percents').val('0');" <?php if ($privat24_fee_percents == 1) { echo "checked=\"checked\"";} ?> /><?php echo $text_percents; ?>
					</label>
				</div>
            </div>
          </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-tax_class">
				<?php echo $entry_tax_class; ?>
			</label>
			<div class="col-sm-10">
				<select name="privat24_fee_tax_class_id" id="input-tax_class" class="form-control">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($tax_classes as $tax_class) { ?>
					  <?php if ($tax_class['tax_class_id'] == $privat24_fee_tax_class_id) { ?>
						<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
					  <?php } else { ?><span data-toggle="tooltip" title="<?php echo $entry_fee_help; ?>">
						<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
					  <?php } ?>
                  <?php } ?>
                </select>
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-custom_title">
				<span data-toggle="tooltip" title="<?php echo $entry_custom_title_help; ?>"><?php echo $entry_custom_title; ?></span>
			</label>
			<div class="col-sm-10">
				<input type="text" name="privat24_fee_custom_title" value="<?php echo $privat24_fee_custom_title; ?>" size="60" placeholder="<?php echo $entry_custom_title; ?>" id="input-custom_title" class="form-control" />
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-status">
				<?php echo $entry_status; ?>
			</label>
			<div class="col-sm-10">
				<select name="privat24_fee_status" id="input-tax_class" class="form-control">
					<?php if ($privat24_fee_status) { ?>
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
			<label class="col-sm-2 control-label" for="input-sort_order">
				<?php echo $entry_sort_order; ?>
			</label>
			<div class="col-sm-10">
				<input type="text" name="privat24_fee_sort_order" value="<?php echo $privat24_fee_sort_order; ?>" placeholder="0" id="input-sort_order" class="form-control" />
			</div>
		  </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>