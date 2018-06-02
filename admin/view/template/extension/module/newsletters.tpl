<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-newsletters" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-newsletters" class="form-horizontal">

						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<td style="width: 1px;" class="text-center">&nbsp</td>
										<td><?php echo $column_news_email; ?></td>
										<td style="width: 100px;"><?php echo $column_news_added; ?></td>
										<td style="width: 100px;" class="text-center"><?php echo $column_remove; ?></td>
									</tr>
								</thead>								
								<tbody>

									<?php if ($newsletters) { ?>
									<?php foreach ($newsletters as $newsletter) { ?>
									<tr id="<?php echo $newsletter['news_id']; ?>"> 
										<td style="width: 1px;" class="text-center">&nbsp</td>										
										<td class="text-left"><?php echo $newsletter['news_email']; ?></td>
										<td style="width: 100px;" class="text-center"><?php echo $newsletter['news_added']; ?></td>                             
										<td style="width: 100px;" class="text-center">
											<span data-toggle="tooltip" title="<?php echo $column_remove; ?>" onclick="remove(<?php echo $newsletter['news_id']; ?>);" class="btn btn-danger" ><i class="fa fa-minus-circle"></i></span>
										</td>                             
									</tr>
									<?php } ?>
									<?php } else { ?>
									<tr>
										<td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
									</tr>
									<?php } ?>
								</tbody>
							</table>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							<div class="col-sm-10">
								<select name="newsletters_status" id="input-status" class="form-control">
									<?php if ($newsletters_status) { ?>
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
	<script>
		function remove(value){
			$.ajax({
				type: 'POST',
				url: 'index.php?route=extension/module/newsletters/unsubscription&token=<?php echo $token; ?>',
				dataType: 'json',
				data: {id: value},
				success: function(data){ 
					if(data.status === 1){
						alert(data.message);
						$("#"+value).remove();
						if(!$('tbody tr').length){
							tr = '<tr><td class="text-center" colspan="8"><?php echo $text_no_results; ?></td></tr>';
							$('tbody').append(tr);
						}
					} else { 
						data.message;
					}
				}
			});

			return false;
		}
	</script>