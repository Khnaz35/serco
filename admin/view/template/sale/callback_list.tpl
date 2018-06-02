<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
       <div class="pull-right">
      <div class="buttons">
	  <a class="btn btn-primary" onclick="$('#form').attr('action', '<?php echo $update; ?>'); $('#form').submit();" class="button"><span  data-toggle="tooltip" title="<?php echo $status_done; ?>" ><i class="fa fa-refresh"></i></span></a>
	  <a class="btn btn-danger" onclick="$('form').submit();" class="button"><span><i class="fa fa-trash-o fa-fw"></i><?php echo $button_delete; ?></span></a>
		<a class="btn btn-primary" href="<?php echo $callback_setting ?>"><span><i class="fa fa-wrench fa-fw"></i><?php echo $button_callback_setting;?></span></a></div>
	</div>
      <h1><?php echo $heading_title_callback; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
	<div class="container-fluid">
	  <?php if ($error_warning) { ?>
	  <div class="alert alert-danger"><?php echo $error_warning; ?></div>
	  <?php } ?>
	  <?php if ($success) { ?>
	  <div class="alert alert-success"><?php echo $success; ?></div>
	  <?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
			</div>
			<div class="panel-body">
				<div class="well">
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-callback-id"><?php echo $text_id; ?></label>
								<input type="text" name="filter_callback_id" value="<?php echo $filter_callback_id;?>" placeholder="<?php echo $text_id; ?>" id="input-callback-id" class="form-control" />
							</div>
							<div class="form-group">
								<label class="control-label" for="input-fio"><?php echo $text_fio; ?></label>
								<input type="text" name="filter_fio" value="<?php echo $filter_fio;?>" placeholder="<?php echo $text_fio; ?>" id="input-fio" class="form-control" />
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-date-added"><?php echo $text_added; ?></label>
								<div class="input-group date">
									<input type="text" name="filter_date_added" value="<?php echo $filter_date_added;?>" placeholder="<?php echo $text_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
									<span class="input-group-btn">
										<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									</span>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label" for="input-phone"><?php echo $text_telephone; ?></label>
								<input type="text" name="filter_phone" value="<?php echo $filter_phone;?>" placeholder="<?php echo $text_telephone; ?>" id="input-phone" class="form-control" />
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-status"><?php echo $text_status; ?></label>
								<select name="filter_status" id="input-status" class="form-control">
								  <option value="*"></option>
								  <?php if ($filter_status) { ?>
								  <option value="1" selected="selected"><?php echo $status_done; ?></option>
								  <?php } else { ?>
								  <option value="1"><?php echo $status_done; ?></option>
								  <?php } ?>
								  <?php if (!$filter_status && !is_null($filter_status)) { ?>
								  <option value="0" selected="selected"><?php echo $status_wait; ?></option>
								  <?php } else { ?>
								  <option value="0"><?php echo $status_wait; ?></option>
								  <?php } ?>
								</select>
							</div>
							<div class="form-group">
								<label class="control-label" for="input-email"><?php echo $text_email_buyer; ?></label>
								<input type="text" name="filter_email" value="<?php echo $filter_email;?>" placeholder="<?php echo $text_email_buyer; ?>" id="input-email" class="form-control" />
							</div>
							<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
						</div>
					</div> 
				</div> 
				<div class="table-responsive">
				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
								<td class="text-left">
									<?php if ($sort == 'call_id') { ?>
										<a href="<?php echo $sort_call_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo $text_id; ?></a>
									<?php } else { ?>
										<a href="<?php echo $sort_call_id; ?>"><?php echo $text_id; ?></a>
									<?php } ?>
								</td>
								<td class="text-left">
									<?php if ($sort == 'name') { ?>
										<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
									<?php } else { ?>
										<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
									<?php } ?>
								</td>
								<td class="text-center"><span data-toggle="tooltip" title="<?php echo $text_callback_url_info; ?>"><?php echo $text_callback_url; ?></span></td>
								<td class="text-center"><?php echo $text_time_callback; ?></td>
								<td class="text-left"><?php echo $text_topic_callback; ?></td>
								<td class="text-left"><?php echo $text_comment; ?></td>
								<td class="text-center">
									<?php if ($sort == 'username') { ?>
										<a href="<?php echo $sort_username; ?>" class="<?php echo strtolower($order); ?>"><?php echo $text_manager; ?></a>
									<?php } else { ?>
										<a href="<?php echo $sort_username; ?>"><?php echo $text_manager; ?></a>
									<?php } ?>
								</td>
								<td class="text-center"><?php echo $text_status; ?></td>
								<td class="text-right"><?php echo $text_added; ?></td>
								<td class="text-right"><?php echo $text_modified; ?></td>
								<td class="text-right"><?php echo $text_action; ?></td>
							</tr>
						</thead>
						<tbody>
							<?php if ($callbacks) { ?>
							<?php foreach ($callbacks as $callback) { ?>
							<tr>
								<td class="text-center">
									<?php if ($callback['selected']) { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" checked="checked" />
									<?php } else { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" />
									<?php } ?>
								</td>
								<td class="text-left"><?php echo $callback['callback_id']; ?></td>
								<td class="text-left">
									<?php if($callback['name']){?><div class="firstname"><i class="fa fa-user fa-fw"></i> <?php echo $callback['name']; ?></div><?php } ?>
									<?php if($callback['telephone']){?><div class="telephone"><i class="fa fa-phone fa-fw"></i><?php echo $callback['telephone']; ?></div><?php } ?>
									<?php if($callback['email_buyer']){?><div class="email"><i class="fa fa-envelope-o fa-fw"></i> <?php echo $callback['email_buyer']; ?></div><?php } ?>
									<?php if($callback['comment_buyer']){?><div class="email"><i class="fa fa fa-comment fa-fw"></i> <?php echo utf8_substr(strip_tags($callback['comment_buyer']),0,50); ?></div><?php } ?>
								</td>
								<td class="text-center"><a class="btn btn-info" href="<?php echo $callback['url_site']; ?>" target="_blank"><i class="fa fa-link" aria-hidden="true"></i> <?php echo $text_link; ?></td>
								<td class="text-center"><?php echo $callback['time_callback_on']; ?></br><?php echo $callback['time_callback_off']; ?></td>
								<td class="text-left"><?php echo $callback['topic_callback_send']; ?></td>
								<td class="text-left"><?php echo utf8_substr(strip_tags($callback['comment']),0,50); ?></td> 
								<td class="text-center"><?php echo $callback['username']; ?></td>
								<?php if ($callback['status'] == $status_done) { ?>
									<td class="text-center" style="background:#0BED0B;"><?php echo $callback['status']; ?></td>
								<?php } else { ?>
									<td class="text-center" style="background:#EDB40B;"><?php echo $callback['status']; ?></td>
								<?php } ?>
								<td class="text-right"><?php echo $callback['date_added']; ?></td>
								<td class="text-right"><?php echo $callback['date_modified']; ?></td>
								<td class="text-right">
									<a class="btn btn-primary" href="<?php echo $callback['action']; ?>" data-toggle="tooltip" title="<?php echo $text_edit; ?>"><i class="fa fa-pencil"></i></a>
								</td>
							</tr>
							<?php } ?>
							<?php } else { ?>
								<tr>
									<td class="center" colspan="9"><?php echo $text_no_results; ?></td>
								</tr>
							<?php } ?>
						</tbody>
					</table>
				</form>
				
				</div> 
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			</div> 
		</div>
	</div>
</div>
<script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=sale/callback&token=<?php echo $token; ?>';

	var filter_callback_id = $('input[name=\'filter_callback_id\']').val();

	if (filter_callback_id) {
		url += '&filter_callback_id=' + encodeURIComponent(filter_callback_id);
	}
	
	var filter_fio = $('input[name=\'filter_fio\']').val();

	if (filter_fio) {
		url += '&filter_fio=' + encodeURIComponent(filter_fio);
	}
	var filter_phone = $('input[name=\'filter_phone\']').val();

	if (filter_phone) {
		url += '&filter_phone=' + encodeURIComponent(filter_phone);
	}
	var filter_email = $('input[name=\'filter_email\']').val();

	if (filter_email) {
		url += '&filter_email=' + encodeURIComponent(filter_email);
	}

	var filter_date_added = $('input[name=\'filter_date_added\']').val();

	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	var filter_status = $('select[name=\'filter_status\']').val();

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
});
//--></script>
  <script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
  <link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script>
<?php echo $footer; ?>
