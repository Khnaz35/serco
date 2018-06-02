<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_install) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_install; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	  
	  
	  <form action="<?=$edit_exchange_rate_action?>" method="post">
		<div class="row">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="input-name1"><?=$exchange_rate_entry?></label>
				<div class="col-sm-9">
					<input placeholder="<?=$exchange_rate_entry?>" type="text" name="exchange_rate" value="<?=$exchange_rate?>" class="form-control">
				</div>
				<div class="col-sm-1">
					<button type="submit" value="Применить" class="btn btn-primary"><i class="fa fa-pencil"></i></button>
				</div>
			</div>
		</div>
	  </form>
    <?php foreach ($rows as $row) { ?>
    <div class="row">
      <?php foreach ($row as $dashboard_1) { ?>
      <?php $class = 'col-lg-' . $dashboard_1['width'] . ' col-md-3 col-sm-6'; ?>
      <?php foreach ($row as $dashboard_2) { ?>
      <?php if ($dashboard_2['width'] > 3) { ?>
      <?php $class = 'col-lg-' . $dashboard_1['width'] . ' col-md-12 col-sm-12'; ?>
      <?php } ?>
      <?php } ?>
      <div class="<?php echo $class; ?>"><?php echo $dashboard_1['output']; ?></div>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
</div>
<?php echo $footer; ?>