<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
    	<div class="container-fluid">
      		<ul class="breadcrumb">
        		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
        			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        		<?php } ?>
      		</ul>
    	</div>
  	</div>
  	<div class="container-fluid">
   		<?php if ($success) { ?>
    		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      			<button type="button" class="close" data-dismiss="alert">&times;</button>
    		</div>
    	<?php } ?>
    <div class="panel panel-default">
    	<div class="panel-heading clearfix">
        	<h3 class="panel-title pull-left" style="padding-top: 9px;"><i class="fa fa-truck"></i> <?php echo $heading_title; ?> v. <?php echo $v; ?> | <?php echo $text_list; ?></h3>
        	<div class="pull-right"> 
      			<div class="btn-group">
      				<button type="submit" id="button-pdf" form="form" formaction="<?php echo $pdf; ?>&type=printDocument" data-toggle="tooltip" title="<?php echo $button_pdf; ?>" class="btn btn-default" disabled="disabled" style="padding-bottom: 7px;"><i class="fa fa-file-pdf-o"></i></button>
  					<button type="button" id="button-pdf" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled="disabled">
    					<span class="caret"></span>
  					</button>
		  			<ul class="dropdown-menu dropdown-menu-right">
		  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printDocument" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-file-text-o"></i> <?php echo $button_ei; ?></button></li>
		  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printMarkings" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-object-group"></i> <?php echo $button_mark; ?></button></li>
		  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printMarkings" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-barcode"></i> <?php echo $button_mark_zebra; ?></button></li>
					</ul>
				</div>
				<div class="btn-group">
      				<a href="<?php echo $print, '/printDocument/type/html/apiKey/', $api_key; ?>" target="_blank" id="print" data-toggle="tooltip" title="<?php echo $button_print; ?>" class="btn btn-default" disabled="disabled" style="padding-bottom: 7px;"><i class="fa fa-print"></i></a>
  					<button type="button" id="print" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled="disabled">
    					<span class="caret"></span>
  					</button>
		  			<ul class="dropdown-menu dropdown-menu-right">
				    	<li><a href="<?php echo $print, '/printDocument/type/html/apiKey/', $api_key; ?>" id="print" target="_blank"><i class="fa fa-file-text-o"></i> <?php echo $button_ei; ?></a></li>
				    	<li><a href="<?php echo $print, '/printMarkings/type/html/apiKey/', $api_key; ?>" id="print" target="_blank"><i class="fa fa-object-group"></i> <?php echo $button_mark; ?></a></li>
				    	<li><a href="<?php echo $print, '/printMarkings/type/html/apiKey/', $api_key, '/zebra/zebra'; ?>" id="print" target="_blank"><i class="fa fa-barcode"></i> <?php echo $button_mark_zebra; ?></a></li>
					</ul>
				</div>
				<a href="<?php echo $edit; ?>" data-toggle="tooltip" title="<?php echo $button_create_ei; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
				<button type="button" id="button-delete" onclick="confirm('<?php echo $text_confirm; ?>') ? deleteEI(this) : false;" data-toggle="tooltip" data-value="" title="<?php echo $button_delete; ?>" class="btn btn-danger" disabled="disabled"><i class="fa fa-trash-o"></i></button>
        		<a href="<?php echo $back_to_orders; ?>" data-toggle="tooltip" title="<?php echo $button_back_to_orders; ?>" class="btn btn-default" style="padding-bottom: 7px;"><i class="fa fa-reply"></i></a>
      		</div>
      	</div>
      	<div class="panel-body">
        	<div class="well">
          		<div class="row">
            		<div class="col-sm-4">
                		<label class="control-label" for="input-ei_number"><?php echo $entry_ei_number; ?></label>

            		</div>
            		<div class="col-sm-4">
                		<label class="control-label" for="input-recipient"><?php echo $entry_recipient; ?></label>
            		</div>
            		<div class="col-sm-4">
                		<label class="control-label" for="input-departure_date_from"><?php echo $entry_departure_date; ?></label>
           	 		</div>
          		</div>
          		<div class="row">
            		<div class="col-sm-4">
                		<input type="text" name="filter_ei_number" value="<?php echo $filter_ei_number; ?>" placeholder="<?php echo $entry_ei_number; ?>" id="input-ei_number" class="form-control" />
            		</div>
            		<div class="col-sm-4">
                		<input type="text" name="filter_recipient" value="<?php echo $filter_recipient; ?>" placeholder="<?php echo $entry_recipient; ?>" id="input-recipient" class="form-control" />
            		</div>
            		<div class="col-sm-2">
                		<div class="input-group date">
                  			<input type="text" name="filter_departure_date_from" value="<?php echo $filter_departure_date_from; ?>" placeholder="<?php echo $entry_departure_date; ?>" data-date-format="DD.MM.YYYY" id="input-departure_date_from" class="form-control" />
                  			<span class="input-group-btn">
                  				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  			</span>
                  		</div>
                  	</div>
                  	<div class="col-sm-2">	
                  		<div class="input-group date">
                  			<input type="text" name="filter_departure_date_to" value="<?php echo $filter_departure_date_to; ?>" placeholder="<?php echo $entry_departure_date; ?>" data-date-format="DD.MM.YYYY" id="input-departure_date_to" class="form-control" />
                  			<span class="input-group-btn">
                  				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  			</span>
                  		</div>
           	 		</div>
          		</div>
          		<div class="row">
          			<div class="form-group">
	            		<div class="col-sm-4 col-sm-offset-8">
	              			<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
	           	 		</div>
	           	 	</div>
          		</div>
        	</div>
        	<form method="post" enctype="multipart/form-data" id="form">
          		<div class="table-responsive">
            		<table class="table table-bordered table-hover">
              			<thead>
                			<tr>
	                  			<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name^=selected]').prop('checked', this.checked); $('input[name^=selected]').triggerHandler('change')" /></td>
	                  			<td style="display: none"></td>
	                  			<td><?php echo $column_ei_number; ?></td>
	                  			<td><?php echo $column_order_number; ?></td>
	                  			<td><?php echo $column_estimated_delivery_date; ?></td>
	                  			<td><?php echo $column_recipient; ?></td>
	                  			<td><?php echo $column_address; ?></td>
	                  			<td><?php echo $column_announced_price; ?></td>
	                  			<td><?php echo $column_shipping_cost; ?></td>
	                  			<td><?php echo $column_state; ?></td>
	                  			<td width="240px"><?php echo $column_action; ?></td>
                			</tr>
              			</thead>
              			<tbody>
              				<?php if ($documents) { ?>
              					<?php foreach ($documents as $document) { ?>
              						<tr>
			              				<td class="text-center">
			                    			<input type="checkbox" name="selected[]" value="<?php echo $document['IntDocNumber']; ?>" />
										</td>
										<td style="display: none">
											<input type="hidden" name="refs[]" value="<?php echo $document['Ref']; ?>" />
										</td>
			                  			<td><?php echo $document['IntDocNumber']; ?></td>
			                  			<td class="text-center">
			                  			<?php if (isset($document['order_id'])) { ?>
											<a href="<?php echo $order, $document['order_id']; ?>" target="_blank"><?php echo $document['order_id']; ?> </a>
										<?php } ?>
										</td>
			                  			<td><?php echo $document['EstimatedDeliveryDate']; ?></td>
			                  			<td><?php echo $document['RecipientContactPerson'], ' ', $document['RecipientContactPhone']; ?></td>
			                  			<td><?php echo $document['CityRecipientDescription'], ', ', $document['RecipientAddressDescription']; ?></td>
			                  			<td><?php echo $document['Cost']; ?></td>
			                  			<td><?php echo $document['CostOnSite']; ?></td>
			                  			<td><?php echo $document['StateName']; ?></td>
			                  			<td class="text-center">
			                    			<div class="btn-group">
									      		<button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printDocument&order=<?php echo $document['IntDocNumber']; ?>" data-toggle="tooltip" title="<?php echo $button_pdf; ?>" class="btn btn-default" ><i class="fa fa-file-pdf-o"></i></button>
									  			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    			<span class="caret"></span>
									  			</button>
									  			<ul class="dropdown-menu dropdown-menu-right">
									  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printDocument&order=<?php echo $document['IntDocNumber']; ?>" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-file-text-o"></i> <?php echo $button_ei; ?></button></li>
									  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printMarkings&order=<?php echo $document['IntDocNumber']; ?>" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-object-group"></i> <?php echo $button_mark; ?></button></li>
									  				<li><button type="submit" form="form" formaction="<?php echo $pdf; ?>&type=printMarkings&order=<?php echo $document['IntDocNumber']; ?>" class="btn btn-link btn-block" style="text-align: left"><i class="fa fa-barcode"></i> <?php echo $button_mark_zebra; ?></button></li>
												</ul>
											</div>
			                    			<div class="btn-group">
									      		<a href="<?php echo $print, '/printDocument/type/html/apiKey/', $api_key, '/orders[]/', $document['IntDocNumber']; ?>" target="_blank" data-toggle="tooltip" title="<?php echo $button_print; ?>" class="btn btn-default"><i class="fa fa-print"></i></a>
									  			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    			<span class="caret"></span>
									  			</button>
									  			<ul class="dropdown-menu dropdown-menu-right">
											    	<li><a href="<?php echo $print, '/printDocument/type/html/apiKey/', $api_key, '/orders[]/', $document['IntDocNumber']; ?>" target="_blank"><i class="fa fa-file-text-o"></i> <?php echo $button_ei; ?></a></li>
											    	<li><a href="<?php echo $print, '/printMarkings/type/html/apiKey/', $api_key, '/orders[]/', $document['IntDocNumber']; ?>" target="_blank"><i class="fa fa-object-group"></i> <?php echo $button_mark; ?></a></li>
											    	<li><a href="<?php echo $print, '/printMarkings/type/html/apiKey/', $api_key, '/orders[]/', $document['IntDocNumber'], '/zebra/zebra'; ?>" target="_blank"><i class="fa fa-barcode"></i> <?php echo $button_mark_zebra; ?></a></li>
												</ul>
											</div>
											<a href="<?php echo $edit, '&ei_ref=', $document['Ref']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
											<button type="button" onclick="confirm('<?php echo $text_confirm; ?>') ? deleteEI(this) : false;" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
			                    		</td>
               			 			</tr>
               					<?php } ?>
               				<?php } else { ?>
               					<tr>
                  					<td class="text-center" colspan="10"><?php echo $text_no_results; ?></td>
                				</tr>
               				<?php } ?>
              			</tbody>
            		</table>
          		</div>
        	</form>
        	<div class="row">
          		<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          		<div class="col-sm-6 text-right"><?php echo $results; ?></div>
       		</div>
      	</div>
    </div>
</div>
<script type="text/javascript"><!-- 
function deleteEI(self) {
	var post_data = (self.id == 'button-delete') ? $('input[name ^= selected]:checked').parents('tr').find('input[name ^= refs]').serialize() : $(self).parents('tr').find('input[name ^= refs]').serialize();

	$.ajax( {
		type: 'POST',
		url: 'index.php?route=extension/shipping/novaposhta/deleteEI&token=<?php echo $token; ?>',
		data: post_data,
		dataType: 'json',
		beforeSend: function () {
			$(self).find('i').addClass('fa-spin');
		},
		success: function(json) {
			$('.alert').remove();
			
			if (json['success']) {
				for(var i in json['success']['refs']) {
					$('input[value = ' + json['success']['refs'][i]['Ref'] + ']').parents('tr').fadeOut('slow');
				}
				
				$('.container-fluid:eq(1)').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success']['text'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
			
			if (json['warning']) {
				for(var w in json['warning']) {			
					$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['warning'][w] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
			}
		},
		complete: function () {
			$(self).find('i').removeClass('fa-spin');
		}
	} );
} 

$(function() {
	$('.date').datetimepicker({
		pickTime: false
	});
	
	if ('<?php echo $ei; ?>') {
		$('tr:contains("<?php echo $ei; ?>")').addClass('success');
	}
		
	$('input[name ^= select]').on('change', function(e) {
		
		var selected = $('input[name ^= selected]:checked'), orders = '';
		
		for(var i = 0; i < selected.length; i++) {
			orders += '/orders[]/' + selected[i].value;
		}
		
		$('a#print').each( function(indx) {
			$(this).attr('href', $(this).attr('href').replace(/\/orders\[\]\/.*/g, ''));
		});
		
		$('a#print').each( function(indx) {
			$(this).attr('href', $(this).attr('href') + orders);
		});
		
		if (selected.length) {
			$('#button-pdf, #print, #button-delete').attr('disabled', false);
		} else {
			$('#button-pdf, #print, #button-delete').attr('disabled', true);
		}
	});
	
	$('#button-filter').on('click', function() {
		url = 'index.php?route=extension/shipping/novaposhta/getEIList&token=<?php echo $token; ?>';

		var filter_departure_date_from = $('input[name = filter_departure_date_from]').val();
		var filter_departure_date_to = $('input[name = filter_departure_date_to]').val();

		if (filter_departure_date_from) {
			url += '&filter_departure_date_from=' + encodeURIComponent(filter_departure_date_from);
		}
		
		if (filter_departure_date_to) {
			url += '&filter_departure_date_to=' + encodeURIComponent(filter_departure_date_to);
		}

		location = url;
	});
});
//--></script>
<?php echo $footer; ?>