<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
 <div class="page-header">
    <div class="container-fluid">
       <div class="pull-right">
      <div class="buttons">
		  <a class="btn btn-primary" onclick="$('#form').submit();" class="button"><span  data-toggle="tooltip" title="<?php echo $button_save; ?>" ><i class="fa fa-save"></i></span></a>
		  <a class="btn btn-default" onclick="location = '<?php echo $cancel; ?>';" class="button"><span  data-toggle="tooltip" title="<?php echo $button_cancel; ?>" ><i class="fa fa-reply"></i></span></a>
	  </div>
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
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit_callback; ?></h3>
			</div>
		<form class="form-horizontal" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<div class="form-group">
				<label class="col-sm-3 control-label" for="input-currency"><?php echo $text_id; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="call_id" value="<?php echo $callback_id; ?>"  disabled />
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_name; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="name" value="<?php echo $name; ?>" />
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $telephone; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="telephone" value="<?php echo $telephone; ?>" />
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_comment; ?></label>
				<div class="col-sm-9">
					<textarea class="form-control" style="width: 50%" rows="4" cols="40" name="comment"><?php echo $comment; ?></textarea>
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_comment_buyer; ?></label>
				<div class="col-sm-9">
					<textarea class="form-control" style="width: 50%" rows="4" cols="40" name="comment_buyer"   disabled><?php echo $comment_buyer; ?></textarea>
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_email_buyer; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="email_buyer" value="<?php echo $email_buyer; ?>"/>
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_manager_form; ?></label>
				<div class="col-sm-9">
					<select class="form-control" name="username">
						<?php if ($username !='') { ?>
							<option value="<?php echo $username ;?>"><?php echo $username; ?></option>
						<?php } else { ?>
							<option value="<?php echo $logged; ?>"><?php echo $logged; ?></option>
						<?php } ?>
						<?php foreach ($users as $user){?>
							<option value="<?php echo $user['username']?>"><?php echo $user['username']?></option>
						<?php }?>
					</select>
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_status; ?></label>
				<div class="col-sm-9">
					<select class="form-control" name="status_id">
						<?php if ($status_id == '0') { ?>
							<option value="0" selected="selected"><?php echo $status_wait; ?></option>
							<option value="1" ><?php echo $status_done; ?></option>
						<?php } else { ?>
							<option value="0" ><?php echo $status_wait; ?></option>
							<option value="1" selected="selected"><?php echo $status_done; ?></option>
						<?php } ?>
					</select>
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_added; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="date_added" value="<?php echo $date_added; ?>"  disabled />
				</div>
            </div>
			<div class="form-group">
				<label class="col-sm-3 control-label"><?php echo $text_modified; ?></label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="date_modified" value="<?php echo $date_modified; ?>"  disabled />
				</div>
            </div>
		</form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
