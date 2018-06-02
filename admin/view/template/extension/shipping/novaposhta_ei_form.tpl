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
  		<?php if (is_array($error_warning)) { ?>
  			<?php foreach ($error_warning as $error) { ?>
    	<div class="alert alert-danger">
    		<i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
      		<button type="button" class="close" data-dismiss="alert">&times;</button>
    	</div>
    		<?php } ?>
    	<?php } elseif ($error_warning) { ?>
		<div class="alert alert-danger">
    		<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      		<button type="button" class="close" data-dismiss="alert">&times;</button>
    	</div>	
    	<?php } ?>
    	<div class="panel panel-default">
      		<div class="panel-heading clearfix">
        		<h3 class="panel-title pull-left" style="padding-top: 9px;"><i class="fa fa-truck"></i> <?php echo $heading_title; ?> v. <?php echo $v; ?> | <?php echo $text_form; ?></h3>
        		<div class="pull-right btn-group">
	      			<a href="<?php echo $ei_list; ?>" data-toggle="tooltip" title="<?php echo $button_ei_list; ?>" class="btn btn-danger"><i class="fa fa-list-ul"></i></a>
	      			<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      			</div>
      		</div>
      		<div class="panel-body">
        		<form class="form-horizontal">
        			<div class="well">
        				<div class="row">
		        			<div class="col-sm-6">
		        				<h3><?php echo $text_sender; ?></h3><hr/>
		        				<fieldset>
		        					<div class="form-group">
		        						<label class="col-sm-4 control-label" for="input-sender"><?php echo $entry_sender; ?></label>
		        						<div class="col-sm-8">
		        							<select name="sender" id="input-sender" class="form-control">
		                						<option value=""><?php echo $text_select; ?></option>
		                						<?php foreach ($senders as $v) { ?>
		                							<?php if ($v['Ref'] == $sender) { ?>
		                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description']; ?><?php echo ($v['CityDescription']) ? ', ' . $v['CityDescription'] : ''; ?></option>
		                							<?php } else { ?>
		                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description']; ?><?php echo ($v['CityDescription']) ? ', ' . $v['CityDescription'] : ''; ?></option>
		               								<?php } ?>
		                						<?php } ?>
		                					</select>	
		            					</div>
		          					</div>
		          					<div class="form-group">
					        			<label class="col-sm-4 control-label" for="input-sender_contact_person"><?php echo $entry_contact_person; ?></label>
					        			<div class="col-sm-8">
					        				<select name="sender_contact_person" id="input-sender_contact_person" class="form-control">
					        					<option value=""><?php echo $text_select; ?></option>
		                						<?php foreach ($sender_contact_persons as $v) { ?>
		                							<?php if ($v['Ref'] == $sender_contact_person) { ?>
		                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description'] . ', ' . $v['Phones']; ?></option>
		                							<?php } else { ?>
		                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description'] . ', ' . $v['Phones']; ?></option>
		               								<?php } ?>
		                						<?php } ?>
					                		</select>	
					            		</div>
					          		</div>
					          		<div class="form-group">
					          			<label class="col-sm-4 control-label" for="input-sender_contact_person_phone"><?php echo $entry_phone; ?></label>
					            		<div class="col-sm-8">
					              			<input type="text" name="sender_contact_person_phone" value="" placeholder="<?php echo $entry_phone; ?>" id="input-sender_contact_person_phone" class="form-control" readonly />
					            		</div>
					          		</div>
					          		<div class="form-group">
					          			<label class="col-sm-4 control-label" for="input-sender_city"><?php echo $entry_city; ?></label>
					            		<div class="col-sm-8">
					              			<input type="text" name="sender_city" value="<?php echo $sender_city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-sender_city" class="form-control" />
					            		</div>
					          		</div>
					          		<div class="form-group">
					        			<label class="col-sm-4 control-label" for="input-sender_address"><?php echo $entry_address; ?></label>
					        			<div class="col-sm-8">
					        				<select name="sender_address" id="input-sender_address" class="form-control">
					        					<option value=""><?php echo $text_select; ?></option>
		                						<?php foreach ($sender_addresses as $v) { ?>
		                							<?php if ($v['Ref'] == $sender_address) { ?>
		                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description']; ?></option>
		                							<?php } else { ?>
		                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description']; ?></option>
		               								<?php } ?>
		                						<?php } ?>
					                		</select>	
					            		</div>
					          		</div>
		        				</fieldset>	
		        			</div>
		        			<div class="col-sm-6" style="border-left: 1px solid #ccc">
		        				<h3><?php echo $text_recipient; ?></h3><hr/>
		        				<div class="form-group">
		          					<label class="col-sm-4 control-label" for="input-recipient"><?php echo $entry_recipient; ?></label>
		            				<div class="col-sm-8">
		              					<input type="text" name="recipient" value="<?php echo $recipient; ?>" placeholder="<?php echo $entry_recipient; ?>" id="input-recipient" class="form-control" />
		              				</div>
		          				</div>
		          				<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-recipient_contact_person"><?php echo $entry_contact_person; ?></label>
				            		<div class="col-sm-8">
				              			<input type="text" name="recipient_contact_person" value="<?php echo $recipient_contact_person; ?>" placeholder="<?php echo $entry_contact_person; ?>" id="input-recipient_contact_person" class="form-control" />
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-recipient_contact_person_phone"><?php echo $entry_phone; ?></label>
				            		<div class="col-sm-8">
				              			<input type="text" name="recipient_contact_person_phone" value="<?php echo $recipient_contact_person_phone; ?>" placeholder="<?php echo $entry_phone; ?>" id="input-recipient_contact_person_phone" class="form-control" />
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none">
				        			<label class="col-sm-4 control-label" for="input-recipient_area"><?php echo $entry_area; ?></label>
				        			<div class="col-sm-8">
				        				<select name="recipient_area" id="input-recipient_area" class="form-control">
				        					<option value=""><?php echo $text_select; ?></option>
				                			<?php foreach ($references['areas'] as $area) { ?> 
				                				<?php if ($area['Ref'] == $recipient_area) { ?>
				                					<option value="<?php echo $area['Ref']; ?>" selected="selected"><?php echo $area['Description']; ?></option>
				                				<?php } else { ?>
													<option value="<?php echo $area['Ref']; ?>"><?php echo $area['Description']; ?></option>
				                				<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-recipient_city"><?php echo $entry_city; ?></label>
				            		<div class="col-sm-8">
				              			<input type="text" name="recipient_city" value="<?php echo $recipient_city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-recipient_city" class="form-control" />
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-recipient_address"><?php echo $entry_address; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				              				<input type="text" name="recipient_address" value="<?php echo $recipient_address; ?>" placeholder="<?php echo $entry_address; ?>" id="input-recipient_address" class="form-control" />
				              				<div class="input-group-btn" data-toggle="buttons">
  											<?php if ($recipient_address_type == 'Warehouse') { ?>
  												<label class="btn btn-default active" data-toggle="tooltip" title="<?php echo $button_warehouse_delivery; ?>"><input type="radio" name="recipient_address_type" value="Warehouse" id="input-recipient_address_type" checked><i class="fa fa-map-marker" aria-hidden="true"></i></label>
  												<label class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_doors_delivery; ?>"><input type="radio" name="recipient_address_type" value="Doors" id="input-recipient_address_type"><i class="fa fa-home" aria-hidden="true"></i></label>
  											<?php } else { ?>
  												<label class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_warehouse_delivery; ?>"><input type="radio" name="recipient_address_type" value="Warehouse" id="input-recipient_address_type"><i class="fa fa-map-marker" aria-hidden="true"></i></label>
  												<label class="btn btn-default active" data-toggle="tooltip" title="<?php echo $button_doors_delivery; ?>"><input type="radio" name="recipient_address_type" value="Doors" id="input-recipient_address_type" checked><i class="fa fa-home" aria-hidden="true"></i></label>
  											<?php } ?>
  											</div> 
  										</div>
				            		</div>
				          		</div>
		        			</div>
	        			</div>
	        			<hr>
	        			<div class="row">
		        			<div class="col-sm-6" style="border-right: 1px solid #ccc">
		        				<h3><?php echo $text_departure_options; ?></h3><hr/>
				        		<div class="form-group">
				        			<label class="col-sm-4 control-label" for="input-departure_type"><?php echo $entry_departure_type; ?></label>
				        			<div class="col-sm-8">
				        				<select name="departure_type" id="input-departure_type" class="form-control">
				                			<?php foreach ($references['cargo_types'] as $cargo_type) { ?> 
				                				<?php if ($cargo_type['Ref'] == $departure) { ?>
				                					<option value="<?php echo $cargo_type['Ref']; ?>" selected="selected"><?php echo $cargo_type['Description']; ?></option>
				                				<?php } else { ?>
													<option value="<?php echo $cargo_type['Ref']; ?>"><?php echo $cargo_type['Description']; ?></option>
				                				<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				          		<?php foreach ($references['tires_and_wheels'] as $t_and_w) { ?>
				          		<div class="form-group" style="display: none;">
				          			<label class="col-sm-4 control-label" for="input-tires_and_wheels_<?php echo $t_and_w['Ref']; ?>"><?php echo $t_and_w['Description']; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				              				<input type="text" name="tires_and_wheels[<?php echo $t_and_w['Ref']; ?>]" value="<?php echo isset($tires_and_wheels[$t_and_w['Ref']]) ? $tires_and_wheels[$t_and_w['Ref']] : ''?>" placeholder="<?php echo $t_and_w['Description']; ?>" id="input-tires_and_wheels_<?php echo $t_and_w['Ref']; ?>" class="form-control" />
				              				<span class="input-group-addon"><?php echo $text_pc; ?></span>
				              			</div>	
				            		</div>
				          		</div>
				          		<?php } ?>
				          		<div class="form-group" style="display: none;">
				          			<label class="col-sm-4 control-label" for="input-width"><?php echo $entry_width; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				              				<input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
				              				<span class="input-group-addon"><?php echo $text_cm; ?></span>
				              			</div>	
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none;">
				          			<label class="col-sm-4 control-label" for="input-length"><?php echo $entry_length; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="length" value="<?php echo $length; ?>" placeholder="<?php echo $entry_length; ?>" id="input-length" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_cm; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none;">
				          			<label class="col-sm-4 control-label" for="input-height"><?php echo $entry_height; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_cm; ?></span>
				              			</div>
				            		</div>
				          		</div>
				        		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-weight"><?php echo $entry_weight; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="weight" value="<?php echo $weight; ?>" placeholder="<?php echo $entry_weight; ?>" id="input-weight" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_kg; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-volume_weight"><?php echo $entry_volume_weight; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				              				<input type="text" name="volume_weight" value="<?php echo $volume_weight; ?>" placeholder="<?php echo $entry_volume_weight; ?>" id="input-volume_weight" class="form-control" readonly/>
				              				<span class="input-group-addon"><?php echo $text_kg; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-volume_general"><?php echo $entry_volume_general; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="volume_general" value="<?php echo $volume_general; ?>" placeholder="<?php echo $entry_volume_general; ?>" id="input-volume_general" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_cubic_meter; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-seats_amount"><?php echo $entry_seats_amount; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				            				<span class="input-group-btn">
				                  				<button type="button" id="button-options_seat" data-toggle="modal" data-target="#optionsSeat" data-tooltip="true" title="<?php echo $button_options_seat; ?>" class="btn btn-default"><i class="fa fa-cubes"></i></button>
				                  			</span>
				                			<input type="text" name="seats_amount" value="<?php echo $seats_amount; ?>" placeholder="<?php echo $entry_seats_amount; ?>" id="input-seats_amount" class="form-control" />
				                  			<span class="input-group-addon"><?php echo $text_pc; ?></span>
				              			</div>
				              			
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-announced_price"><?php echo $entry_announced_price; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
				            				<span class="input-group-btn">
				            					<button type="button" id="button-components_list" data-toggle="modal" data-target="#totalsList" data-tooltip="true" title="<?php echo $button_components_list; ?>" class="btn btn-default"><i class="fa fa-list" aria-hidden="true"></i></button>
				            				</span>	
					              			<input type="text" name="announced_price" value="<?php echo $announced_price; ?>" placeholder="<?php echo $entry_announced_price; ?>" id="input-announced_price" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_grn; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-departure_description"><?php echo $entry_departure_description; ?></label>
				            		<div class="col-sm-8">
				              			<input type="text" name="departure_description" value="<?php echo $departure_description; ?>" placeholder="<?php echo $entry_departure_description; ?>" id="input-departure_description" class="form-control" />
				            		</div>
				          		</div>
		        			</div>
				        	<div class="col-sm-6">
				        		<h3><?php echo $text_payment; ?></h3><hr/>
				        		<div class="form-group">
				        			<label class="col-sm-4 control-label" for="input-payer"><?php echo $entry_payer; ?></label>
				        			<div class="col-sm-8">
				        				<select name="payer" id="input-payer" class="form-control">
				                			<?php foreach ($references['payer_types'] as $payer_type) { ?>
				                				<?php if ($payer_type['Ref'] == 'ThirdPerson' && !$sender_options['CanPayTheThirdPerson']) { ?>
				                					<option value="<?php echo $payer_type['Ref']; ?>" disabled><?php echo $payer_type['Description']; ?></option>
				                				<?php } elseif ($payer_type['Ref'] == $payer) { ?>
				                					<option value="<?php echo $payer_type['Ref']; ?>" selected="selected"><?php echo $payer_type['Description']; ?></option>
				                				<?php } else { ?>
				                					<option value="<?php echo $payer_type['Ref']; ?>"><?php echo $payer_type['Description']; ?></option>
				               					<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none">
				        			<label class="col-sm-4 control-label" for="input-third_person"><?php echo $entry_third_person; ?></label>
				        			<div class="col-sm-8">
				        				<select name="third_person" id="input-third_person" class="form-control">
		                					<option value=""><?php echo $text_select; ?></option>
		                					<?php foreach ($references['third_persons'] as $third_person) { ?>
		                						<option value="<?php echo $third_person['Ref']; ?>"><?php echo $third_person['Description']; ?>, <?php echo $third_person['CityDescription']; ?></option>
		                					<?php } ?>
		                				</select>
				            		</div>
				          		</div>
				          		<div class="form-group">
				        			<label class="col-sm-4 control-label" for="input-payment_type"><?php echo $entry_payment_type; ?></label>
				        			<div class="col-sm-8">
				        				<select name="payment_type" id="input-payment_type" class="form-control">
				                			<?php foreach ($references['payment_types'] as $payment_type) { ?>
				                				<?php if ($payment_type['Ref'] == 'NonCash' && !$sender_options['CanNonCashPayment']) { ?>
				                					<option value="<?php echo $payment_type['Ref']; ?>" disabled><?php echo $payment_type['Description']; ?></option>
				                				<?php } elseif ($payment_type['Ref'] == 'Cash') { ?>
				                					<option value="<?php echo $payment_type['Ref']; ?>" selected="selected"><?php echo $payment_type['Description']; ?></option>
				                				<?php } else { ?>
				                					<option value="<?php echo $payment_type['Ref']; ?>"><?php echo $payment_type['Description']; ?></option>
				               					<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				          		<div class="form-group">
				        			<label class="col-sm-4 control-label" for="input-backward_delivery"><?php echo $entry_backward_delivery; ?></label>
				        			<div class="col-sm-8">
				        				<select name="backward_delivery" id="input-backward_delivery" class="form-control">
				        					<option value="0"><?php echo $text_no_backward_delivery; ?></option>
				                			<?php foreach ($references['backward_delivery_types'] as $backward_delivery_type) { ?>
					                			<?php if ($backward_delivery_type['Ref'] == $cod) { ?>
					                				<option value="<?php echo $backward_delivery_type['Ref']; ?>" selected="selected"><?php echo $backward_delivery_type['Description']; ?></option>
					                			<?php } else { ?>
					                				<option value="<?php echo $backward_delivery_type['Ref']; ?>"><?php echo $backward_delivery_type['Description']; ?></option>
					               				<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none">
				          			<label class="col-sm-4 control-label" for="input-backward_delivery_total"><?php echo $entry_backward_delivery_total; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="backward_delivery_total" value="<?php echo $backward_delivery_total; ?>" placeholder="<?php echo $entry_backward_delivery_total; ?>" id="input-backward_delivery_total" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_grn; ?></span>
				              			</div>
				            		</div>
				          		</div>
				          		<div class="form-group" style="display: none">
				        			<label class="col-sm-4 control-label" for="input-backward_delivery_payer"><?php echo $entry_backward_delivery_payer; ?></label>
				        			<div class="col-sm-8">
				        				<select name="backward_delivery_payer" id="input-backward_delivery_payer" class="form-control">
				                			<?php foreach ($references['backward_delivery_payers'] as $backward_delivery_payer) { ?>
				                				<?php if ($backward_delivery_payer['Ref'] == $cod_payer) { ?>
				                					<option value="<?php echo $backward_delivery_payer['Ref']; ?>" selected="selected"><?php echo $backward_delivery_payer['Description']; ?></option>
				                				<?php } else { ?>
				                					<option value="<?php echo $backward_delivery_payer['Ref']; ?>"><?php echo $backward_delivery_payer['Description']; ?></option>
				               					<?php } ?>
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>
				        	</div>
			        	</div>
			        	<hr>
			        	<div class="row">
			        		<h3 class="text-center"><?php echo $text_additionally; ?></h3><hr/>
				        	<div class="col-sm-6">
				          		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-sales_order_number"><?php echo $entry_sales_order_number; ?></label>
				            		<div class="col-sm-8">
				              			<input type="text" name="sales_order_number" value="<?php echo $sales_order_number; ?>" placeholder="<?php echo $entry_sales_order_number; ?>" id="input-sales_order_number" class="form-control" />
				          			</div>
				          		</div>
				          		<div class="form-group"<?php echo (!$sender_options['CanAfterpaymentOnGoodsCost']) ? ' style="display: none"' : ''; ?>>
				          			<label class="col-sm-4 control-label" for="input-payment_control"><?php echo $entry_payment_control; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group">
					              			<input type="text" name="payment_control" value="<?php echo $payment_control; ?>" placeholder="<?php echo $entry_payment_control; ?>" id="input-payment_control" class="form-control" />
					              			<span class="input-group-addon"><?php echo $text_grn; ?></span>
				              			</div>
				          			</div>
				          		</div>	
				          		<div class="form-group">	
				          			<label class="col-sm-4 control-label" for="input-additional_information"><?php echo $entry_additional_information; ?></label>
				            		<div class="col-sm-8">
				            			<textarea name="additional_information" rows="3" id="input-additional_information" maxlength="100" class="form-control"><?php echo $additional_information; ?></textarea>
				          			</div>
				          		</div>
				        	</div>
				        	<div class="col-sm-6">
				        		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-departure_date"><?php echo $entry_departure_date; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group date">
				                			<input type="text" name="departure_date" value="<?php echo $departure_date; ?>" placeholder="<?php echo $entry_departure_date; ?>" data-date-format="DD.MM.YYYY" id="input-departure_date" class="form-control">
				                  			<span class="input-group-btn">
				                  				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				                  			</span>
				              			</div>
				            		</div>
				            	</div>
				        		<div class="form-group">
				          			<label class="col-sm-4 control-label" for="input-preferred_delivery_date"><?php echo $entry_preferred_delivery_date; ?></label>
				            		<div class="col-sm-8">
				            			<div class="input-group date">
				                			<input type="text" name="preferred_delivery_date" value="<?php echo $preferred_delivery_date; ?>" placeholder="<?php echo $entry_preferred_delivery_date; ?>" data-date-format="DD.MM.YYYY" id="input-preferred_delivery_date" class="form-control">
				                  			<span class="input-group-btn">
				                  				<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
				                  			</span>
				              			</div>
				            		</div>
				            	</div>
				            	<div class="form-group" style="display: none">
				        			<label class="col-sm-4 control-label" for="input-time_interval"><?php echo $entry_preferred_delivery_time; ?></label>
				        			<div class="col-sm-8">
				        				<select name="time_interval" id="input-time_interval" class="form-control">
				        					<option value=""><?php echo $text_during_day; ?></option>
				        					<?php if (isset($time_intervals) && $time_intervals) { ?> 
				                				<?php foreach ($time_intervals as $interval) { ?> 
				                					<?php if ($interval['Number'] == $time_interval) { ?>
				                					<option value="<?php echo $interval['Number']; ?>" selected="selected"><?php echo $interval['Start'] . ' - ' . $interval['End']; ?></option>
				                					<?php } else { ?>
													<option value="<?php echo $interval['Number']; ?>"><?php echo $interval['Start'] . ' - ' . $interval['End']; ?></option>
				                					<?php } ?>
				                				<?php } ?>	
				                			<?php } ?>
				                		</select>	
				            		</div>
				          		</div>	
				        	</div>
				        </div>	
			        	<div class="clearfix"></div>
		        	</div>
        			<button type="button" class="btn btn-primary btn-lg btn-block" id="button-save"><?php echo $button_save_ei; ?></button>
        			<!-- Modal seats start -->
					<div class="modal fade" id="optionsSeat" tabindex="-1" role="dialog" aria-labelledby="optionSeatLabel">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title" id="optionsSeatLabel"><?php echo $heading_options_seat; ?></h4>
								</div>
								<div class="modal-body">
									<div class="table-responsive">
										<table class="table table-striped" id="table-seats">
											<thead>
												<tr>
													<td class="text-center"><?php echo $column_number_order; ?></td>
													<td class="text-center"><?php echo $column_volume; ?></td>
													<td class="text-center"></td>
													<td class="text-center"><?php echo $column_width; ?></td>
													<td class="text-center"><?php echo $column_length; ?></td>
													<td class="text-center"><?php echo $column_height; ?></td>
													<td class="text-center"><?php echo $column_actual_weight; ?></td>
													<td class="text-center"><?php echo $column_volume_weight; ?></td>
							                  		<td class="text-center" width="100px"><?php echo $column_action; ?></td>
							                  	</tr>
							                </thead>
							                <tbody>
							                </tbody>
							                <tfoot>
							                  	<tr>
							                  		<td colspan="8"></td>
							                  		<td class="text-center">
							                  			<button type="button" onclick="addSeat()" data-toggle="modal"  data-tooltip=true title="<?php echo $button_add_seat; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
							                  			</td>
							                  	</tr>
							                  </tfoot>
							            </table>
							        </div>
								</div>
								<div class="modal-footer">
									<button type="button" onclick="saveSeats();" class="btn btn-primary"><i class="fa fa-check"></i></button>
									<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i></button>
									
								</div>
							</div>
						</div>
					</div>
					<!-- Modal seats end -->
					<!-- Modal of totals list start -->
					<div class="modal fade" id="totalsList" tabindex="-1" role="dialog" aria-labelledby="totalsListLabel">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title" id="totalsListLabel"><?php echo $heading_components_list; ?></h4>
								</div>
								<div class="modal-body">
									<div class="table-responsive">
										<table class="table table-striped" id="table-totals_list">
											<thead>
												<tr>
													<td><?php echo $column_description; ?></td>
													<td class="text-center"><?php echo $column_price; ?></td>
							                  		<td class="text-center"><?php echo $column_action; ?></td>
							                  	</tr>
							                </thead>
							                <tbody>
								            <?php foreach ($totals as $i => $total) { ?>
								                <tr>
									                <td><?php echo $total['title']; ?></td>
													<td class="text-center"><?php echo $total['price']; ?> <?php echo $text_grn; ?></td>
													<td class="text-center">
													<?php if ($total['status']) { ?>
														<button type="button" class="btn btn-danger btn-xs" id="total_announced_price_minus"><i class="fa fa-minus"></i></button>
													<?php } else { ?>	
														<button type="button" class="btn btn-success btn-xs" id="total_announced_price_plus"><i class="fa fa-plus"></i></button>
													<?php } ?>	
													</td>
												</tr>
											<?php } ?>	
							                </tbody>
							                <tfoot>
							                  	<tr>
							                  		<td><strong><?php echo $text_announced_price; ?></strong></td>
							                  		<td class="text-center" id="announced_price_total"><strong><?php echo $announced_price; ?> <?php echo $text_grn; ?></strong></td>
							                  		<td></td>
							                  	</tr>
							                  </tfoot>
							            </table>
							        </div>
								</div>
								<div class="modal-footer">
									<button type="button" onclick="saveAnnouncedPrice();" class="btn btn-primary"><i class="fa fa-check"></i></button>
									<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i></button>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal of totals list end-->
        		</form>
      		</div>
    	</div>
  	</div>
</div>
<script type="text/javascript"><!--
function getNPData(type) {
	var action, sender, city, checked, post_data;	
		
	switch(type) {
		case 'sender_contact_person':
			action = 'getContactPerson';
			checked = '<?php echo $sender_contact_person; ?>';
			sender = $('#input-sender').val();
			
			break;
		
		case 'sender_address':
			action = 'getAddress';
			checked = '<?php echo $sender_address; ?>';
			sender = $('#input-sender').val();
			city = $('input[name = sender_city]').val();
			
			break;
	}
	
	if (action) {
		post_data = 'action=' + action;
	}
	
	if (sender) {
		post_data += '&sender=' + encodeURIComponent(sender);
	}
	
	if (city) {
		post_data += '&city=' + encodeURIComponent(city);
	}
				
	$.ajax( {
		url: 'index.php?route=extension/shipping/novaposhta/getNPData&token=<?php echo $token; ?>',
		type: 'post',
		data: post_data,
		dataType: 'json',
		success: function (json) {
			var html = '<option value=""><?php echo $text_select; ?></option>';
				
			for (var i in json) {
				if  (action == 'getContactPerson') {
					json[i]['Description'] += ', ' + json[i]['Phones'];
				}
					
				if (json[i]['Ref'] == checked) {
					html += '<option value="' + json[i]['Ref'] + '" selected="selected">' + json[i]['Description'] + '</option>';
				} else {
					html += '<option value="' + json[i]['Ref'] + '">' + json[i]['Description'] + '</option>';
				}
			}
				
			$('#input-' + type).html(html);
		}
	} );
}

function validateForm(element) {
	var v = element.name + '=' + encodeURIComponent(element.value), f = '';
		
	if (element.name == 'sender_contact_person') {
		f += '&sender=' + encodeURIComponent($('select[name = sender]').val());
	}
	
	if (element.name == 'sender_address') {
		f += '&sender=' + encodeURIComponent($('select[name = sender]').val());
		f += '&filter=' + encodeURIComponent($('input[name = sender_city]').val());
	}
	
	if (element.name == 'recipient_city') {
		f += '&recipient_address_type=' + encodeURIComponent($('input[name = recipient_address_type]:checked').val());
	}

	if (element.name == 'recipient_address') {
		f += '&filter=' + encodeURIComponent($('input[name = recipient_city]').val());
		f += '&recipient_address_type=' + encodeURIComponent($('input[name = recipient_address_type]:checked').val());
	}
		
	if (element.name == 'backward_delivery_total') {
		f += '&backward_delivery=' + encodeURIComponent($('select[name = backward_delivery]').val());
	}
	
	$.ajax( {
		url: 'index.php?route=extension/shipping/novaposhta/getForm&token=<?php echo $token; ?>' + f,
	   	type: 'POST',
	   	data: v,
	   	dataType: 'json',
	  	success: function(json) {
	  			checkErrors(json);
	   	},
	   	error: function (jqXHR, textStatus, errorThrown) {
	   		console.log(textStatus);
	     }
	} );
}		

function checkErrors(array) {
	if (array['warning']) {
		if (array['warning'] instanceof Array) {
			for(var w in array['warning']) {			
				$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + array['warning'][w] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
		} else {
			$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + array['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}
		
	} else {
		$('.alert').remove();
	}	
		
	for(var field in array['errors']) {
		if (field == 'recipient_address_list') {
			var select = '<select name="recipient_address" id="input-recipient_address" class="form-control"><option value=""><?php echo $text_select; ?></option>';
			
			for(var i in array['errors'][field]) {
				select += '<option value="' + array['errors'][field][i]['Description'] + '">' + array['errors'][field][i]['Description'] + '</option>';
			}
			
			select += '</select>';
			
			$('#input-recipient_address').replaceWith(select);
			field = 'input-recipient_address';	
		}				
		$('div.form-group').has('label[for = input-' + field + ']').removeClass('has-success').addClass('has-error');
		$('span#input-' + field).remove('.help-block');
		$('div.form-group > div[class ^= col-sm]').has('#input-' + field).append('<span id="input-' + field + '" class="help-block">' + array['errors'][field] + '</span>');
	}
	
	for(var field in array['success']) {			
		$('div.form-group').has('label[for = input-' + field + ']').removeClass('has-error').addClass('has-success');
		$('span#input-' + field).remove('.help-block');
	}
}

function addSeat() {
	var row = '<tr>';
	
	row += '<td>' + ($('#table-seats tbody tr').length + 1) + '</td>';	
	row += '<td><div class="input-group"><input type="text" name="volume" value="" id="seat-volume" class="form-control" /><span class="input-group-addon"><?php echo $text_cubic_meter; ?></span></div></td>';
	row += '<td><label class="col-sm-12 control-label"><?php echo $text_or; ?></label></td>';
	row += '<td><div class="input-group"><input type="text" name="width" value="" id="seat-width" class="form-control" /><span class="input-group-addon"><?php echo $text_cm; ?></span></div></td>';
	row += '<td><div class="input-group"><input type="text" name="length" value="" id="seat-length" class="form-control" /><span class="input-group-addon"><?php echo $text_cm; ?></span></div></td>';
	row += '<td><div class="input-group"><input type="text" name="height" value="" id="seat-height" class="form-control" /><span class="input-group-addon"><?php echo $text_cm; ?></span></div></td>';
	row += '<td><div class="input-group"><input type="text" name="actual_weight" value="" id="seat-actual-weight" class="form-control" /><span class="input-group-addon"><?php echo $text_kg; ?></span></div></td>';
	row += '<td><div class="input-group"><input type="text" name="volume_weight" value="" id="seat-volume-weight" class="form-control" readonly/><span class="input-group-addon"><?php echo $text_kg; ?></span></div></td>';
	row += '<td><div class="btn-group" role="group"><button type="button" onclick="$(this).parents(\'tr\').find(\'input\').val(\'\')" class="btn btn-default"><i class="fa fa-eraser"></i></button><button type="button" onclick="$(this).parents(\'tr\').remove()" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></div></td>';
	row += '</tr>';
		
	$('#table-seats tbody').append(row);
}

function saveSeats() {
	var trs = $('#table-seats tbody tr');
	var seats = trs.length, weight = 0, volume = 0, volume_weight = 0;	
		
	trs.each(function(i, element){
		tr = $(element);	
			
		weight += +tr.find('#seat-actual-weight').val();
		volume += +tr.find('#seat-volume').val();
		volume_weight += +tr.find('#seat-volume-weight').val();
	});
		
	$('#input-seats_amount').val(seats);
	$('#input-weight').val(weight);
	$('#input-volume_general').val(volume);
	$('#input-volume_weight').val(volume_weight);
		
	$('#optionsSeat').modal('hide');
}

function saveAnnouncedPrice() {
	$('#input-announced_price').val(parseInt($('#announced_price_total')[0].outerText));
	
	$('#totalsList').modal('hide');
}

function formHandler(element) {
	switch(element.id) {
		case 'input-sender':
			getNPData('sender_contact_person');
			
			$.ajax( {
				url: 'index.php?route=extension/shipping/novaposhta/getNPData&token=<?php echo $token; ?>',
				type: 'post',
				data: 'action=getSenderOptions&sender=' + element.value,
				dataType: 'json',
				success: function (json) {
					if (json['CanPayTheThirdPerson']) {
						$('#input-payer > option[value = ThirdPerson]').attr('disabled', false);
					} else {
						$('#input-payer > option[value = ThirdPerson]').attr({'disabled': true, 'selected': false}).trigger('change');
					}
					
					if (json['CanNonCashPayment']) {
						$('#input-payment_type > option[value = NonCash]').attr('disabled', false);
					} else {
						$('#input-payment_type > option[value = Cash]').attr({'disabled': false, 'selected': true});
						$('#input-payment_type > option[value = NonCash]').attr({'disabled': true, 'selected': false});
						
					}
					
					if (json['CanAfterpaymentOnGoodsCost']) {
						$('[for = input-payment_control]').filter(':hidden').parent().show();
					} else {
						$('[for = input-payment_control]').filter(':visible').parent().hide();
					}
				}
			} );
			
			break;
		
		case 'input-sender_contact_person':
			var phone = element.selectedOptions[0].label.substr(element.selectedOptions[0].label.indexOf(', ') + 2);

			$('#input-sender_contact_person_phone').val(phone);
			
			break;
		
		case 'input-sender_city':
			getNPData('sender_address');
			
			break;
			
		case 'input-recipient_city':
			var address_type = $('#input-recipient_address_type:checked').val(),
				delivery_date = $('#input-preferred_delivery_date').val();
				
				if (address_type == 'Doors' && delivery_date) {
					$.ajax( {
						url: 'index.php?route=extension/shipping/novaposhta/getNPData&token=<?php echo $token; ?>',
						type: 'post',
						data: 'action=getTimeIntervals&city=' + encodeURIComponent(element.value) + '&delivery_date=' + delivery_date,
						dataType: 'json',
						success: function (json) {
							var html = '<option value=""><?php echo $text_during_day; ?></option>';
				
							for (var i in json) {
								html += '<option value="' + json[i]['Number'] + '">' + json[i]['Start'] + ' - ' + json[i]['End'] + '</option>';
							}
								
							$('#input-time_interval').html(html);
						}
					} );
				}
			
			break;			
		
		case 'input-recipient_address':
			if (element.value.match(/почтомат|поштомат/i)) {
				if (departure_type.value == 'Cargo') {
					$('[for = input-width], [for = input-length], [for = input-height]').filter(':hidden').parent().show();
				} else if (departure_type.value == 'TiresWheels' || departure_type.value == 'Pallet'){
					$('#input-departure_type').val('Cargo').trigger('change');
				}
				
				$('#input-departure_type > option[value = TiresWheels], #input-departure_type > option[value = Pallet], #input-seats_amount, button#button-options_seat').attr('disabled', true);
				$('#input-seats_amount').val('1');
			} else {
				$('[for = input-width], [for = input-length], [for = input-height]').filter(':visible').parent().hide();
				$('#input-departure_type > option[value = TiresWheels], #input-departure_type > option[value = Pallet], #input-seats_amount, button#button-options_seat').attr('disabled', false);
			}
			
			recipient_address = element;
			
			break;
		
		case 'input-recipient_address_type':
			if (element.value == 'Doors') {
				$('[for = input-recipient_area]').filter(':hidden').parent().show();
				
				if ($('#input-preferred_delivery_date').val()) {
					$('[for = input-time_interval]').filter(':hidden').parent().show();
				}
			} else {
				$('[for = input-recipient_area], [for = input-time_interval]').filter(':visible').parent().hide();
			}		

			break;	
		
		case 'input-departure_type':
			if (element.value == 'Cargo') {
				$('[for *= input-tires_and_wheels]').filter(':visible').parent().hide();
				$('[for = input-weight], [for = input-volume_weight], [for = input-volume_general]').filter(':hidden').parent().show();
				$('button#button-options_seat, #input-seats_amount, #input-departure_description').attr('disabled', false);			
				
				if (recipient_address.value.match(/почтомат|поштомат/i)) {
					$('[for = input-width], [for = input-length], [for = input-height]').filter(':hidden').parent().show();
					$('button#button-options_seat, #input-seats_amount').attr('disabled', true);
					$('#input-seats_amount').val('1');
				}
		   	} else if (element.value == 'Documents') {
				$('[for *= input-tires_and_wheels], [for = input-volume_weight], [for = input-volume_general]').filter(':visible').parent().hide();
				$('[for = input-weight]').filter(':hidden').parent().show();
				$('button#button-options_seat, #input-seats_amount').attr('disabled', false);			
				$('#input-departure_description').attr('disabled', true).val('Документи');
				
				if (recipient_address.value.match(/почтомат|поштомат/i)) {
					$('[for = input-width], [for = input-length], [for = input-height]').filter(':visible').parent().hide();
					$('button#button-options_seat, #input-seats_amount').attr('disabled', true);
					$('#input-seats_amount').val('1');
				}
		   	} else if (element.value == 'TiresWheels') {				
				$('[for = input-width], [for = input-length], [for = input-height], [for = input-weight], [for = input-volume_weight], [for = input-volume_general]').filter(':visible').parent().hide();
				$('[for *= input-tires_and_wheels]').filter(':hidden').parent().show();
				$('button#button-options_seat, #input-seats_amount, #input-departure_description').attr('disabled', true);
				$('#input-seats_amount').val('');
				$('#input-departure_description').val('Шини та диски');
		   	}
		   	
		   	departure_type = element;
			
			break;

		case (element.id.match(/input-tires_and_wheels_/) || {}).input:
			$('#input-seats_amount').val(Number($('#input-seats_amount').val()) + Number(element.value));
			
			break;
		
		case 'input-volume_general':
			$('#input-volume_weight').val((element.value * 250).toFixed(3));
			
			break;
			
		case 'seat-volume':
			$(element).parents('tr').find('#seat-volume-weight').val((element.value * 250).toFixed(3));
			
			break;
			
		case 'input-width':
		case 'input-length':
		case 'input-height':
			$('#input-volume_general').val(($('#input-width').val() * $('#input-length').val() * $('#input-height').val() / 1000000).toFixed(3)).trigger('change');
			
			break;
			
		case 'seat-width':
		case 'seat-length':
		case 'seat-height':
			var row = $(element).parents('tr'), width = row.find('#seat-width').val(), length = row.find('#seat-length').val(), height = row.find('#seat-height').val();
			
			row.find('#seat-volume').val((width * length * height / 1000000).toFixed(3)).trigger('change');	
			
			break;
		
		case 'input-payer':
			if (element.value == 'ThirdPerson') {
				$('[for = input-third_person]').filter(':hidden').parent().show();
				$('#input-payment_type > option[value = Cash]').attr('disabled', true);
				$('#input-payment_type > option[value = NonCash]').attr('selected', true);
			} else {
				$('[for = input-third_person]').filter(':visible').parent().hide();
				$('#input-payment_type > option[value = Cash]').attr({'disabled': false, 'selected': true});
			}
			
			break;
		
		case 'input-backward_delivery':
			if (element.value == 'Money') {
				$('[for = input-backward_delivery_total], [for = input-backward_delivery_payer]').filter(':hidden').parent().show();
			} else {
				$('[for = input-backward_delivery_total], [for = input-backward_delivery_payer]').filter(':visible').parent().hide();
			}
			
			backward_delivery = element.value;
			
			break;
		
		case 'input-preferred_delivery_date':
			if (element.value && $('#input-recipient_address_type:checked').val() == 'Doors') {
				$('[for = input-time_interval]').filter(':hidden').parent().show();
				$('#input-recipient_city').trigger('change')
			} else {
				$('[for = input-time_interval]').filter(':visible').parent().hide();
			}		

			break;		
	}		
}

var sender_contact_person = $('#input-sender_contact_person')[0];
var recipient_address = $('#input-recipient_address')[0];
var recipient_address_type = $('#input-recipient_address_type:checked')[0];
var departure_type = $('#input-departure_type')[0];
var backward_delivery = $('#input-backward_delivery')[0];

$( function () {
	$('[data-tooltip=true]').tooltip();
	$('div#optionsSeat').find('.modal-dialog').css('width', '85%');
	$('.date').datetimepicker( {pickTime: false} )
	.on('change', function () {
		var input = $(this).find('input')[0];
		formHandler(input);
		validateForm(input);
	} );

	formHandler(sender_contact_person);
	formHandler(recipient_address);
	formHandler(recipient_address_type);
	formHandler(departure_type);
	formHandler(backward_delivery);

	// Change totals list
	$('div#totalsList').on('click', 'button#total_announced_price_minus, button#total_announced_price_plus', function (e) {
		var b = $(e.currentTarget),
			cost = parseInt(b.parents('tr').find('td:eq(1)').text()),
			total = $('#announced_price_total')[0].outerText; 
			
		if (e.currentTarget.id == 'total_announced_price_minus') {
			b.replaceWith('<button type="button" class="btn btn-success btn-xs" id="total_announced_price_plus"><i class="fa fa-plus"></i></button>');
			
			total = total.replace(/-?\d+/, parseInt(total) - cost);
		} else {
			b.replaceWith('<button type="button" class="btn btn-danger btn-xs" id="total_announced_price_minus"><i class="fa fa-minus"></i></button>');
			
			total = total.replace(/-?\d+/, parseInt(total) + cost);
		}
		
		$('#announced_price_total').html('<strong>' + total + '</strong>');
	} );
	
	// Save EI
	$('form').on('click', '#button-save', function () {
		var button = $('#button-save');
		
		$.ajax( {
			url: 'index.php?route=extension/shipping/novaposhta/saveEI&order_id=<?php echo $order_id; ?>&ei_ref=<?php echo $ei_ref; ?>&token=<?php echo $token; ?>',
	   		type: 'POST',
	   		data: $('input[type != radio], input[type = radio]:checked, select, textarea').filter(':visible'),
	   		dataType: 'json',
	   		beforeSend: function() {
	   			button.replaceWith('<div class="progress" id="button-save"><div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%"><span class="sr-only">100% Complete</span></div></div>');
	   		},
	  		success: function(json) {
	  				if (json['redirect']) {
						location.href = 'index.php?route=extension/shipping/novaposhta/getEIList&filter_departure_date_from=' + json['departure_date'] + '&token=<?php echo $token; ?>';
					} else {
						$('.help-block, .alert').remove();
						$('div').removeClass('has-error has-success');
						
						checkErrors(json);
					}
	   		},
	   		error: function (jqXHR, textStatus, errorThrown) {
	   			console.log(textStatus);
	      	},
	      	complete: function(json){
				$('#button-save').replaceWith(button);
				
				if (json['errors'] != 'undefined' || json['warning'] != 'undefined') {
					$('body').animate({ scrollTop: $('.has-error, .alert').offset().top }, 1000); 
				}
			}
	   	} );
	});
	
	// Search recipient
	$('input[name = recipient]').autocomplete( {
		source: function(request, response) {
			var post_data = 'recipient_name=' + encodeURIComponent(request);
			
			$.ajax({
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'post',
				data: post_data,
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['AllDescription'],
							value: item['Description']
						}
					}));
				}
			});
		},
		select: function(item) {
			$(this).val(item['value']).trigger('change');
		}
	} );
	
	// Search city
	$('input[name = sender_city], input[name = recipient_city]').autocomplete( {
		source: function(request, response) {
			var post_data = 'city=' + encodeURIComponent(request);
			
			if (this.name == 'recipient_city' && $('#input-recipient_address_type:checked').val() == 'Doors') {
				post_data += '&area=' + $('#input-recipient_area').val();
			}

			$.ajax({
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'post',
				data: post_data,
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['Description'],
							value: item['CityName'] || item['Description']
						}
					}));
				}
			});
		},
		select: function(item) {
			$(this).val(item['value']).trigger('change');
		}
	} );
	
	// Search address
	$('input[name = recipient_address]').autocomplete( {
		source: function(request, response) {
			var post_data,
				recipient_address_type = $('#input-recipient_address_type:checked').val(),
				filter = $('#input-recipient_city').val();
			
			if (recipient_address_type == 'Warehouse') {
				post_data = 'filter=' + encodeURIComponent(filter) + '&warehouse=' + encodeURIComponent(request);
			} else if (recipient_address_type == 'Doors') {
				post_data = 'filter=' + encodeURIComponent(filter) + '&doors=' + encodeURIComponent(request);
			}

			$.ajax({
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'post',
				data: post_data,
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['Description'],
							value: item['Description']						
						}
					} ));
				}
			});
		},
		select: function(item) {
			$(this).val(item['value']).trigger('change');
		}
	} );

	// Departure description
	$('input[name = departure_description]').autocomplete({
		source: function(request, response) {
			var post_data = 'departure_description=' + encodeURIComponent(request);
			
			$.ajax( {
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'post',
				data: post_data,
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['Description'],
							value: item['Description'],
						}
					}));
				}
			} );
		},
		select: function(item) {
			$(this).val(item['value']);
		}
	} );
	
	// Change handler
	$('form').on('change', 'input, select, textarea', function() {
		setTimeout(formHandler, 200, this);
		setTimeout(validateForm, 200, this);
	} );
});	
//--></script>
<?php echo $footer; ?>