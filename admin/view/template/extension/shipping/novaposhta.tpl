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
    	<div class="alert alert-success">
    		<i class="fa fa-check-circle"></i> <?php echo $success; ?>
      		<button type="button" class="close" data-dismiss="alert">&times;</button>
    	</div>
    	<?php } ?>
    	<?php if ($error_warning) { ?>
    	<div class="alert alert-danger">
    		<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      		<button type="button" class="close" data-dismiss="alert">&times;</button>
    	</div>
    	<?php } ?>
    	<div class="panel panel-default">
      		<div class="panel-heading clearfix">
        		<h3 class="panel-title pull-left" style="padding-top: 9px;"><i class="fa fa-truck"></i> <?php echo $heading_title; ?> v. <?php echo $v; ?></h3>
        		<div class="pull-right btn-group">
					<button onclick="save();" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success"><i class="fa fa-save"></i></button>
					<button type="submit" form="form-novaposhta" data-toggle="tooltip" title="<?php echo $button_save_and_exit; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
					<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
				</div>
      		</div>
      		<div class="panel-body">
        		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-novaposhta" class="form-horizontal">
        			<ul class="nav nav-tabs">
        				<?php if ($license) { ?>
			  			<li<?php if ($license) { ?> class="active"<?php } ?>><a href="#tab-general" data-toggle="tab"><i class="fa fa-cogs"></i> <?php echo $tab_general; ?></a></li>
			  			<li><a href="#tab-database" data-toggle="tab"><i class="fa fa-database"></i> <?php echo $tab_database; ?></a></li>
			  			<li><a href="#tab-sender" data-toggle="tab"><i class="fa fa-user" aria-hidden="true"></i> <?php echo $tab_sender; ?></a></li>
			  			<li><a href="#tab-recipient" data-toggle="tab"><i class="fa fa-users" aria-hidden="true"></i> <?php echo $tab_recipient; ?></a></li>
			  			<li><a href="#tab-departure" data-toggle="tab"><i class="fa fa-cube" aria-hidden="true"></i> <?php echo $tab_departure; ?></a></li>
			  			<li><a href="#tab-cron" data-toggle="tab"><i class="fa fa-tasks"></i> <?php echo $tab_cron; ?></a></li>
		  				<?php } ?>
		  				<li<?php if (!$license) { ?> class="active"<?php } ?>><a href="#tab-support" data-toggle="tab"><i class="fa fa-life-ring"></i> <?php echo $tab_support; ?></a></li>
					</ul>
					<div class="tab-content">
						<?php if ($license) { ?>
						<div class="tab-pane fade<?php if ($license) { ?>in active<?php } ?>" id="tab-general">
							<div class="col-sm-2">
								<ul class="nav nav-pills nav-stacked">
									<li class="active"><a href="#tab-global" data-toggle="pill"><?php echo $tab_global; ?></a></li>
						  			<li><a href="#tab-warehouse" data-toggle="pill"><?php echo $tab_warehouse; ?></a></li>
						  			<li><a href="#tab-doors" data-toggle="pill"><?php echo $tab_doors; ?></a></li>
								</ul>
							</div>
							<div class="col-sm-10">
								<div class="tab-content">
									<div class="tab-pane active" id="tab-global">
										<div class="form-group">
			            					<label class="col-sm-2 control-label" for="input-status"><span data-toggle="tooltip" title="<?php echo $help_status; ?>"><?php echo $entry_status; ?></span></label>
			            					<div class="col-sm-4">
			            						<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_status) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_status" value="0"><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_status" value="1" id="input-status" checked><?php echo $text_enabled; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_status" value="0" checked><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_status" value="1" id="input-status"><?php echo $text_enabled; ?></label>
									            <?php } ?>
				      							</div>
			            					</div>
			            					<label class="col-sm-2 control-label" for="input-debugging_mode"><span data-toggle="tooltip" title="<?php echo $help_debugging_mode; ?>"><?php echo $entry_debugging_mode; ?></span></label>
			            					<div class="col-sm-4">
			            						<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_debugging_mode) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_debugging_mode" value="0"><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_debugging_mode" value="1" id="input-debugging_mode" checked><?php echo $text_enabled; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_debugging_mode" value="0" checked><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_debugging_mode" value="1" id="input-debugging_mode"><?php echo $text_enabled; ?></label>
									            <?php } ?>
				      							</div>
			            					</div>
			            				</div>
			            				<div class="form-group">
			            					<label class="col-sm-2 control-label" for="input-sort_order"><span data-toggle="tooltip" title="<?php echo $help_sort_order; ?>"><?php echo $entry_sort_order; ?></span></label>
			            					<div class="col-sm-10">
			              						<input type="text" name="novaposhta_sort_order" value="<?php echo $novaposhta_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort_order" class="form-control" />
			            					</div>
			            				</div>
			            				<div class="form-group required">
					            			<label class="col-sm-2 control-label" for="input-key_api"><span data-toggle="tooltip" title="<?php echo $help_key_api; ?>"><?php echo $entry_key_api; ?></span></label>
					            			<div class="col-sm-10">
					              				<input type="text" name="novaposhta_key_api" value="<?php echo $novaposhta_key_api; ?>" placeholder="<?php echo $entry_key_api; ?>" id="input-key_api" class="form-control" />
					            			</div>
					          			</div>
					          			<div class="form-group">
					            			<label class="col-sm-2 control-label" for="input-tariffs"><span data-toggle="tooltip" title="<?php echo $help_tariffs; ?>"><?php echo $entry_tariffs; ?></span></label>
					            			<div class="col-sm-1">
					              				<a class="btn btn-primary btn-block" role="button" data-toggle="tooltip" title="<?php echo $button_tariffs; ?>" id="button-tariff"><i class="fa fa-calculator"></i></a>
					            			</div>
					          			</div>
					          			<div class="form-group">
			                  				<label class="col-sm-2 control-label" for="input-payment_cod"><span data-toggle="tooltip" title="<?php echo $help_payment_cod; ?>"><?php echo $entry_payment_cod; ?></span></label>
			            					<div class="col-sm-10">
			              						<select name="novaposhta_payment_cod" id="input-payment_cod" class="form-control">
			                						<option value="0"><?php echo $text_select; ?></option>
			                						<?php foreach ($payment_methods as $code => $title) { ?>
			                							<?php if ($code == $novaposhta_payment_cod) { ?>
			                								<option value="<?php echo $code; ?>" selected="selected"><?php echo $title; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $code; ?>"><?php echo $title; ?></option>
			               								<?php } ?>
			                						<?php } ?>
			              						</select>
			            					</div>
			            				</div>
			            				<div class="form-group">
					          				<label class="col-sm-2 control-label" for="input-image"><span data-toggle="tooltip" title="<?php echo $help_image; ?>"><?php echo $entry_image; ?></span></label>
					          				<div class="col-sm-4">
					          					<a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
					          					<input type="hidden" name="novaposhta_image" value="<?php echo $novaposhta_image; ?>" id="input-image" />
					          				</div>
					          				<label class="col-sm-2 control-label" for="input-image_output_place"><span data-toggle="tooltip" title="<?php echo $help_image_output_place; ?>"><?php echo $entry_image_output_place; ?></span></label>
					          				<div class="col-sm-4">
					          					<select name="novaposhta_image_output_place" id="input-image_output_place" class="form-control">
					          						<option value="0"><?php echo $text_select; ?></option>
			                						<?php foreach ($image_output_places as $code => $name) { ?>
			                							<?php if ($code == $novaposhta_image_output_place) { ?>
			                								<option value="<?php echo $code; ?>" selected="selected"><?php echo $name; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $code; ?>"><?php echo $name; ?></option>
			               								<?php } ?>
			                						<?php } ?>
			              						</select>
					          				</div>
					          			</div>
					          			<div class="form-group">
										    <label class="col-sm-2 control-label" for="input-free_cost_text" style="padding-top: 3%"><span data-toggle="tooltip" title="<?php echo $help_free_cost_text; ?>"><?php echo $entry_free_cost_text; ?></span></label>
										    <div class="col-sm-10">
										        <ul class="nav nav-tabs" role="tablist">
										            <?php foreach ($languages as $language) { ?>
										            	<li<?php echo ($language_id == $language['language_id']) ? ' class="active"' : '' ?>><a href="#free_cost_text_<?php echo $language['language_id']; ?>" aria-controls="free_cost_text_<?php echo $language['language_id']; ?>" role="tab" data-toggle="tab"><img src="<?php echo ${'language_flag_' . $language['language_id']} ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
										            <?php } ?>	
										        </ul>
										        <div class="tab-content">
											        <?php foreach ($languages as $language) { ?>
											    		<div role="tabpanel" class="tab-pane<?php echo ($language_id == $language['language_id']) ? ' active' : '' ?>" id="free_cost_text_<?php echo $language['language_id']; ?>">	
											              	<input type="text" name="novaposhta_free_cost_text_<?php echo $language['language_id']; ?>" value="<?php echo ${'novaposhta_free_cost_text_' . $language['language_id']}; ?>" placeholder="<?php echo $entry_free_cost_text; ?>" id="input-free_cost_text" class="form-control" />
											            </div>
											        <?php } ?>
										        </div>
										    </div>
										</div>
									</div>
									<div class="tab-pane fade" id="tab-warehouse">
										<div class="form-group">
			            					<label class="col-sm-2 control-label" for="input-warehouse_status"><span data-toggle="tooltip" title="<?php echo $help_method_status; ?>"><?php echo $entry_method_status; ?></span></label>
			            					<div class="col-sm-10">
			            						<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['status']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][status]" value="0"><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][status]" value="1" id="input-warehouse_status" checked><?php echo $text_enabled; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][status]" value="0" checked><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][status]" value="1" id="input-warehouse_status"><?php echo $text_enabled; ?></label>
									            <?php } ?>
				      							</div>
			            					</div>
			            				</div>
										<div class="form-group">
								            <label class="col-sm-2 control-label" for="input-warehouse_name" style="padding-top: 3%"><span data-toggle="tooltip" title="<?php echo $help_name; ?>"><?php echo $entry_name; ?></span></label>
								            <div class="col-sm-10">
								            	<ul class="nav nav-tabs" role="tablist">
								            		<?php foreach ($languages as $language) { ?>
								            			<li<?php echo ($language_id == $language['language_id']) ? ' class="active"' : '' ?>><a href="#warehouse_name_<?php echo $language['language_id']; ?>" aria-controls="warehouse_name_<?php echo $language['language_id']; ?>" role="tab" data-toggle="tab"><img src="<?php echo ${'language_flag_' . $language['language_id']} ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
								            		<?php } ?>	
								            	 </ul>
								            	<div class="tab-content">
									            	<?php foreach ($languages as $language) { ?>
									    				<div role="tabpanel" class="tab-pane<?php echo ($language_id == $language['language_id']) ? ' active' : '' ?>" id="warehouse_name_<?php echo $language['language_id']; ?>">	
									              			<input type="text" name="novaposhta_shipping_methods[Warehouse][name_<?php echo $language['language_id']; ?>]" value="<?php echo $novaposhta_shipping_methods['Warehouse']['name_' . $language['language_id']]; ?>" placeholder="<?php echo $entry_name; ?>" id="input-warehouse_name" class="form-control" />
									              		</div>
									              	<?php } ?>
								            	</div>
								        	</div>
								        </div>
			          					<div class="form-group">
			           						<label class="col-sm-2 control-label" for="input-warehouse_geo_zone_id"><span data-toggle="tooltip" title="<?php echo $help_geo_zone; ?>"><?php echo $entry_geo_zone; ?></span></label>
			            					<div class="col-sm-10">
			              						<select name="novaposhta_shipping_methods[Warehouse][geo_zone_id]" id="input-warehouse_geo_zone_id" class="form-control">
			                						<option value="0"><?php echo $text_all_zones; ?></option>
			               							<?php foreach ($geo_zones as $geo_zone) { ?>
			               								<?php if ($geo_zone['geo_zone_id'] == $novaposhta_shipping_methods['Warehouse']['geo_zone_id']) { ?>
			               									<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
			                							<?php } ?>
			               							<?php } ?>
			              						</select>
			            					</div>
			            				</div>
			            				<div class="form-group">	
			            					<label class="col-sm-2 control-label" for="input-warehouse_tax_class_id"><span data-toggle="tooltip" title="<?php echo $help_tax_class; ?>"><?php echo $entry_tax_class; ?></span></label>
			            					<div class="col-sm-10">
			              						<select name="novaposhta_shipping_methods[Warehouse][tax_class_id]" id="input-warehouse_tax_class_id" class="form-control">
			                						<option value="0"><?php echo $text_none; ?></option>
			                						<?php foreach ($tax_classes as $tax_class) { ?>
			                							<?php if ($tax_class['tax_class_id'] == $novaposhta_shipping_methods['Warehouse']['tax_class_id']) { ?>
			                								<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
			               								<?php } ?>
			                						<?php } ?>
			              						</select>
			            					</div>
			          					</div>
			          					<div class="form-group">
			          						<label class="col-sm-2 control-label" for="input-warehouse_minimum_order_amount"><span data-toggle="tooltip" title="<?php echo $help_minimum_order_amount; ?>"><?php echo $entry_minimum_order_amount; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Warehouse][minimum_order_amount]" value="<?php echo $novaposhta_shipping_methods['Warehouse']['minimum_order_amount']; ?>" placeholder="<?php echo $entry_minimum_order_amount; ?>" id="input-warehouse_minimum_order_amount" class="form-control" />
			            					</div>
			            					<label class="col-sm-2 control-label" for="input-warehouse_maximum_order_amount"><span data-toggle="tooltip" title="<?php echo $help_maximum_order_amount; ?>"><?php echo $entry_maximum_order_amount; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Warehouse][maximum_order_amount]" value="<?php echo $novaposhta_shipping_methods['Warehouse']['maximum_order_amount']; ?>" placeholder="<?php echo $entry_maximum_order_amount; ?>" id="input-warehouse_maximum_order_amount" class="form-control" />
			            					</div>
			                    			<label class="col-sm-2 control-label" for="input-warehouse_free_shipping"><span data-toggle="tooltip" title="<?php echo $help_free_shipping; ?>"><?php echo $entry_free_shipping; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Warehouse][free_shipping]" value="<?php echo $novaposhta_shipping_methods['Warehouse']['free_shipping']; ?>" placeholder="<?php echo $entry_free_shipping; ?>" id="input-warehouse_free_shipping" class="form-control" />
			            					</div>
			                    		</div>
			          					<div class="form-group">
			                    			<label class="col-sm-2 control-label" for="input-warehouse_cost"><span data-toggle="tooltip" title="<?php echo $help_cost; ?>"><?php echo $entry_cost; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['cost']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][cost]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][cost]" value="1" id="input-warehouse_cost" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][cost]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][cost]" value="1" id="input-warehouse_cost"><?php echo $text_yes; ?></label>
									            <?php } ?>
				      							</div>
			                    			</div>
			                    			<label class="col-sm-2 control-label" for="input-warehouse_api_calculation"><span data-toggle="tooltip" title="<?php echo $help_api_calculation; ?>"><?php echo $entry_api_calculation; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['api_calculation']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][api_calculation]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][api_calculation]" value="1" id="input-warehouse_api_calculation" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][api_calculation]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][api_calculation]" value="1" id="input-warehouse_api_calculation"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                    			<label class="col-sm-2 control-label" for="input-warehouse_tariff_calculation"><span data-toggle="tooltip" title="<?php echo $help_tariff_calculation; ?>"><?php echo $entry_tariff_calculation; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['tariff_calculation']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][tariff_calculation]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][tariff_calculation]" value="1" id="input-warehouse_tariff_calculation" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][tariff_calculation]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][tariff_calculation]" value="1" id="input-warehouse_tariff_calculation"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                    		</div>
			                    		<div class="form-group">
			                    			<label class="col-sm-2 control-label" for="input-warehouse_deliver_period"><span data-toggle="tooltip" title="<?php echo $help_delivery_period; ?>"><?php echo $entry_delivery_period; ?></span></label>
			                    			<div class="col-sm-10">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['delivery_period']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][delivery_period]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][delivery_period]" value="1" id="input-warehouse_deliver_period" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][delivery_period]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][delivery_period]" value="1" id="input-warehouse_deliver_period"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                  			</div>
			                  			<div class="form-group">	
			                    			<label class="col-sm-2 control-label" for="input-warehouses_filter_weight"><span data-toggle="tooltip" title="<?php echo $help_warehouses_filter_weight; ?>"><?php echo $entry_warehouses_filter_weight; ?></span></label>
			                    			<div class="col-sm-10">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Warehouse']['warehouses_filter_weight']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][warehouses_filter_weight]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][warehouses_filter_weight]" value="1" id="input-warehouses_filter_weight" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][warehouses_filter_weight]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Warehouse][warehouses_filter_weight]" value="1" id="input-warehouses_filter_weight"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                  			</div>
			            				<div class="form-group">
			            					<label class="col-sm-2 control-label" for="input-warehouse_types"><span data-toggle="tooltip" title="<?php echo $help_warehouse_types; ?>"><?php echo $entry_warehouse_types; ?></span></label>
			            					<div class="col-sm-10">
			            						<div class="well well-sm" style="height: 160px; overflow: auto;">
			            							<?php if (is_array($warehouse_types)) { ?>
			            								<?php foreach ($warehouse_types as $warehouse_type) { ?>
			            								<div class="checkbox">
			            									<label>
			            										<?php if (isset($novaposhta_shipping_methods['Warehouse']['warehouse_types']) && is_array($novaposhta_shipping_methods['Warehouse']['warehouse_types']) && in_array($warehouse_type['Ref'], $novaposhta_shipping_methods['Warehouse']['warehouse_types'])) { ?>
			            										<input type="checkbox" name="novaposhta_shipping_methods[Warehouse][warehouse_types][]" value="<?php echo $warehouse_type['Ref']; ?>" checked="checked" /> <?php echo $warehouse_type['Description']; ?>
			            										<?php } else { ?>
			            										<input type="checkbox" name="novaposhta_shipping_methods[Warehouse][warehouse_types][]" value="<?php echo $warehouse_type['Ref']; ?>" /> <?php echo $warehouse_type['Description']; ?>
			            										<?php } ?>
			            									</label>
			            								</div>
			            								<?php } ?>
			            							<?php } ?>
			            						</div>
			            					</div>
			            				</div>
		            				</div>
		            				<div class="tab-pane" id="tab-doors">
										<div class="form-group">
			            					<label class="col-sm-2 control-label" for="input-doors_status"><span data-toggle="tooltip" title="<?php echo $help_method_status; ?>"><?php echo $entry_method_status; ?></span></label>
			            					<div class="col-sm-10">
			            						<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Doors']['status']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][status]" value="0"><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][status]" value="1" id="input-doors_status" checked><?php echo $text_enabled; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][status]" value="0" checked><?php echo $text_disabled; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][status]" value="1" id="input-doors_status"><?php echo $text_enabled; ?></label>
									            <?php } ?>
				      							</div>
			            					</div>
			            				</div>
										<div class="form-group">
								            <label class="col-sm-2 control-label" for="input-doors_name" style="padding-top: 3%"><span data-toggle="tooltip" title="<?php echo $help_name; ?>"><?php echo $entry_name; ?></span></label>
								            <div class="col-sm-10">
								            	<ul class="nav nav-tabs" role="tablist">
								            		<?php foreach ($languages as $language) { ?>
								            			<li<?php echo ($language_id == $language['language_id']) ? ' class="active"' : '' ?>><a href="#Doors_name_<?php echo $language['language_id']; ?>" aria-controls="Doors_name_<?php echo $language['language_id']; ?>" role="tab" data-toggle="tab"><img src="<?php echo ${'language_flag_' . $language['language_id']} ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
								            		<?php } ?>	
								            	 </ul>
								            	<div class="tab-content">
									            	<?php foreach ($languages as $language) { ?>
									    				<div role="tabpanel" class="tab-pane<?php echo ($language_id == $language['language_id']) ? ' active' : '' ?>" id="Doors_name_<?php echo $language['language_id']; ?>">	
									              			<input type="text" name="novaposhta_shipping_methods[Doors][name_<?php echo $language['language_id']; ?>]" value="<?php echo $novaposhta_shipping_methods['Doors']['name_' . $language['language_id']]; ?>" placeholder="<?php echo $entry_name; ?>" id="input-doors_name" class="form-control" />
									              		</div>
									              	<?php } ?>
								            	</div>
								        	</div>
								        </div>
			          					<div class="form-group">
			           						<label class="col-sm-2 control-label" for="input-doors_geo_zone_id"><span data-toggle="tooltip" title="<?php echo $help_geo_zone; ?>"><?php echo $entry_geo_zone; ?></span></label>
			            					<div class="col-sm-10">
			              						<select name="novaposhta_shipping_methods[Doors][geo_zone_id]" id="input-doors_geo_zone_id" class="form-control">
			                						<option value="0"><?php echo $text_all_zones; ?></option>
			               							<?php foreach ($geo_zones as $geo_zone) { ?>
			               								<?php if ($geo_zone['geo_zone_id'] == $novaposhta_shipping_methods['Doors']['geo_zone_id']) { ?>
			               									<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
			                							<?php } ?>
			               							<?php } ?>
			              						</select>
			            					</div>
			            				</div>
			            				<div class="form-group">	
			            					<label class="col-sm-2 control-label" for="input-doors_tax_class_id"><span data-toggle="tooltip" title="<?php echo $help_tax_class; ?>"><?php echo $entry_tax_class; ?></span></label>
			            					<div class="col-sm-10">
			              						<select name="novaposhta_shipping_methods[Doors][tax_class_id]" id="input-doors_tax_class_id" class="form-control">
			                						<option value="0"><?php echo $text_none; ?></option>
			                						<?php foreach ($tax_classes as $tax_class) { ?>
			                							<?php if ($tax_class['tax_class_id'] == $novaposhta_shipping_methods['Doors']['tax_class_id']) { ?>
			                								<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
			                							<?php } else { ?>
			                								<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
			               								<?php } ?>
			                						<?php } ?>
			              						</select>
			            					</div>
			          					</div>
			          					<div class="form-group">
			          						<label class="col-sm-2 control-label" for="input-doors_minimum_order_amount"><span data-toggle="tooltip" title="<?php echo $help_minimum_order_amount; ?>"><?php echo $entry_minimum_order_amount; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Doors][minimum_order_amount]" value="<?php echo $novaposhta_shipping_methods['Doors']['minimum_order_amount']; ?>" placeholder="<?php echo $entry_minimum_order_amount; ?>" id="input-doors_minimum_order_amount" class="form-control" />
			            					</div>
			            					<label class="col-sm-2 control-label" for="input-doors_maximum_order_amount"><span data-toggle="tooltip" title="<?php echo $help_maximum_order_amount; ?>"><?php echo $entry_maximum_order_amount; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Doors][maximum_order_amount]" value="<?php echo $novaposhta_shipping_methods['Doors']['maximum_order_amount']; ?>" placeholder="<?php echo $entry_maximum_order_amount; ?>" id="input-doors_maximum_order_amount" class="form-control" />
			            					</div>
			                    			<label class="col-sm-2 control-label" for="input-doors_free_shipping"><span data-toggle="tooltip" title="<?php echo $help_free_shipping; ?>"><?php echo $entry_free_shipping; ?></span></label>
			            					<div class="col-sm-2">
			              						<input type="text" name="novaposhta_shipping_methods[Doors][free_shipping]" value="<?php echo $novaposhta_shipping_methods['Doors']['free_shipping']; ?>" placeholder="<?php echo $entry_free_shipping; ?>" id="input-doors_free_shipping" class="form-control" />
			            					</div>
			                    		</div>
			          					<div class="form-group">
			                    			<label class="col-sm-2 control-label" for="input-doors_cost"><span data-toggle="tooltip" title="<?php echo $help_cost; ?>"><?php echo $entry_cost; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Doors']['cost']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][cost]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][cost]" value="1" id="input-doors_cost" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][cost]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][cost]" value="1" id="input-doors_cost"><?php echo $text_yes; ?></label>
									            <?php } ?>
				      							</div>
			                    			</div>
			                    			<label class="col-sm-2 control-label" for="input-doors_api_calculation"><span data-toggle="tooltip" title="<?php echo $help_api_calculation; ?>"><?php echo $entry_api_calculation; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Doors']['api_calculation']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][api_calculation]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][api_calculation]" value="1" id="input-doors_api_calculation" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][api_calculation]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][api_calculation]" value="1" id="input-doors_api_calculation"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                    			<label class="col-sm-2 control-label" for="input-doors_tariff_calculation"><span data-toggle="tooltip" title="<?php echo $help_tariff_calculation; ?>"><?php echo $entry_tariff_calculation; ?></span></label>
			                    			<div class="col-sm-2">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Doors']['tariff_calculation']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][tariff_calculation]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][tariff_calculation]" value="1" id="input-doors_tariff_calculation" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][tariff_calculation]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][tariff_calculation]" value="1" id="input-doors_tariff_calculation"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                    		</div>
			                    		<div class="form-group">
			                    			<label class="col-sm-2 control-label" for="input-doors_deliver_period"><span data-toggle="tooltip" title="<?php echo $help_delivery_period; ?>"><?php echo $entry_delivery_period; ?></span></label>
			                    			<div class="col-sm-10">
			                    				<div class="btn-group" data-toggle="buttons">
				      							<?php if ($novaposhta_shipping_methods['Doors']['delivery_period']) { ?>
									                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][delivery_period]" value="0"><?php echo $text_no; ?></label>
				      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][delivery_period]" value="1" id="input-doors_deliver_period" checked><?php echo $text_yes; ?></label>
									                <?php } else { ?>
									                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][delivery_period]" value="0" checked><?php echo $text_no; ?></label>
				      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_shipping_methods[Doors][delivery_period]" value="1" id="input-doors_deliver_period"><?php echo $text_yes; ?></label>
									            <?php } ?>                    				
												</div>
			                    			</div>
			                  			</div>
		            				</div>
								</div>
							</div>
                  		</div>
          				<div class="tab-pane fade" id="tab-database">
          					<div class="table-responsive">
            					<table class="table table-bordered table-hover">
              						<thead>
                						<tr>
                  							<td class="text-center"><?php echo $column_type; ?></td>
                  							<td class="text-center"><?php echo $column_date; ?></td>
                  							<td class="text-center"><?php echo $column_amount; ?></td>
                  							<td class="text-center"><?php echo $column_description; ?></td>
                  							<td class="text-center"><?php echo $column_action; ?></td>
                						</tr>
              						</thead>
              						<tbody>
                						<tr>
                  							<td class="text-left"><?php echo $entry_update_areas; ?></td>
                  							<td class="text-center"><?php if(!empty($database['areas']['update_datetime'])) {echo $database['areas']['update_datetime'];} ?></td>
                  							<td class="text-center" id="areasamount"><?php if(!empty($database['areas']['amount'])) {echo $database['areas']['amount'];} ?></td>
                  							<td class="text-left"><?php echo $help_update_areas; ?></td>
                  							<td class="text-center">
                  								<a onclick="update('areas')" id="button-update_areas" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $text_update; ?>"><i class="fa fa-refresh"></i></a>
                  							</td>
               			 				</tr>
               			 				<tr>
                  							<td class="text-left"><?php echo $entry_update_cities; ?></td>
                  							<td class="text-center"><?php if(!empty($database['cities']['update_datetime'])) {echo $database['cities']['update_datetime'];} ?></td>
                  							<td class="text-center" id="citiesamount"><?php if(!empty($database['cities']['amount'])) {echo $database['cities']['amount'];} ?></td>
                  							<td class="text-left"><?php echo $help_update_cities; ?></td>
                  							<td class="text-center">
                  								<a onclick="update('cities')" id="button-update_cities" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $text_update; ?>"><i class="fa fa-refresh"></i></a>
                  							</td>
               			 				</tr>
               			 				<tr>
                  							<td class="text-left"><?php echo $entry_update_warehouses; ?></td>
                  							<td class="text-center"><?php if(!empty($database['warehouses']['update_datetime'])) {echo $database['warehouses']['update_datetime'];} ?></td>
                  							<td class="text-center" id="warehousesamount"><?php if(!empty($database['warehouses']['amount'])) {echo $database['warehouses']['amount'];} ?></td>
                  							<td class="text-left"><?php echo $help_update_warehouses; ?></td>
                  							<td class="text-center">
                  								<a onclick="update('warehouses')" id="button-update_warehouses" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $text_update; ?>"><i class="fa fa-refresh"></i></a>
                  							</td>
               			 				</tr>
               			 				<tr>
                  							<td class="text-left"><?php echo $entry_update_references; ?></td>
                  							<td class="text-center"><?php if(!empty($database['references']['update_datetime'])) {echo $database['references']['update_datetime'];} ?></td>
                  							<td class="text-center" id="referencesamount"><?php if(!empty($database['references']['amount'])) {echo $database['references']['amount'];} ?></td>
                  							<td class="text-left"><?php echo $help_update_references; ?></td>
                  							<td class="text-center">
                  								<a onclick="update('references')" id="button-update_references" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $text_update; ?>"><i class="fa fa-refresh"></i></a>
                  							</td>
               			 				</tr>
              						</tbody>
            					</table>
          					</div>
          				</div>
          				<div class="tab-pane fade" id="tab-sender">
          					<div class="form-group required">
          						<label class="col-sm-2 control-label" for="input-sender"><span data-toggle="tooltip" title="<?php echo $help_sender; ?>"><?php echo $entry_sender; ?></span></label>
            					<div class="col-sm-10">
              						<select name="novaposhta_sender" id="input-sender" class="form-control">
                						<option value=""><?php echo $text_select; ?></option>
                						<?php foreach ($senders as $v) { ?>
                							<?php if ($v['Ref'] == $novaposhta_sender) { ?>
                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description']; ?><?php echo ($v['CityDescription']) ? ', ' . $v['CityDescription'] : ''; ?></option>
                							<?php } else { ?>
                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description']; ?><?php echo ($v['CityDescription']) ? ', ' . $v['CityDescription'] : ''; ?></option>
               								<?php } ?>
                						<?php } ?>
              						</select>
            					</div>
          					</div>
              				<div class="form-group required">
            					<label class="col-sm-2 control-label" for="input-sender_contact_person"><span data-toggle="tooltip" title="<?php echo $help_sender_contact_person; ?>"><?php echo $entry_contact_person; ?></span></label>
            					<div class="col-sm-10">
              						<select name="novaposhta_sender_contact_person" id="input-sender_contact_person" class="form-control">
              							<option value=""><?php echo $text_select; ?></option>
                						<?php foreach ($sender_contact_persons as $v) { ?>
                							<?php if ($v['Ref'] == $novaposhta_sender_contact_person) { ?>
                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description'] . ', ' . $v['Phones']; ?></option>
                							<?php } else { ?>
                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description'] . ', ' . $v['Phones']; ?></option>
               								<?php } ?>
                						<?php } ?>
              						</select>
              					</div>
              				</div>
              				<div class="form-group required">
            					<label class="col-sm-2 control-label" for="input-sender_city"><span data-toggle="tooltip" title="<?php echo $help_sender_city; ?>"><?php echo $entry_city; ?></span></label>
            					<div class="col-sm-10">
              						<input type="text" name="novaposhta_sender_city_name" value="<?php echo $novaposhta_sender_city_name; ?>" placeholder="<?php echo $entry_city; ?>" id="input-sender_city" class="form-control" />
              						<input type="hidden" name="novaposhta_sender_city" value="<?php echo $novaposhta_sender_city; ?>" />
              					</div>
              				</div>
              				<div class="form-group required">
            					<label class="col-sm-2 control-label" for="input-sender_address"><span data-toggle="tooltip" title="<?php echo $help_sender_address; ?>"><?php echo $entry_address; ?></span></label>
            					<div class="col-sm-10">
              						<select name="novaposhta_sender_address" id="input-sender_address" class="form-control">
              							<option value=""><?php echo $text_select; ?></option>
                						<?php foreach ($sender_addresses as $v) { ?>
                							<?php if ($v['Ref'] == $novaposhta_sender_address) { ?>
                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description']; ?></option>
                							<?php } else { ?>
                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description']; ?></option>
               								<?php } ?>
                						<?php } ?>
              						</select>
              						<input type="hidden" name="novaposhta_sender_address_type" value="<?php echo $novaposhta_sender_address_type; ?>" />
              					</div>
              				</div>
          				</div>
          				<div class="tab-pane fade" id="tab-recipient">
          					<div class="form-group required">
            					<label class="col-sm-2 control-label" for="input-recipient"><span data-toggle="tooltip" title="<?php echo $help_recipient; ?>"><?php echo $entry_recipient; ?></span></label>
            					<div class="col-sm-10">
              						<input type="text" name="novaposhta_recipient_name" value="<?php echo $novaposhta_recipient_name; ?>" placeholder="<?php echo $entry_recipient; ?>" id="input-recipient" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_contact_person"><span data-toggle="tooltip" title="<?php echo $help_recipient_contact_person; ?>"><?php echo $entry_contact_person; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_recipient_contact_person" value="<?php echo $novaposhta_recipient_contact_person; ?>" placeholder="<?php echo $entry_contact_person; ?>" id="input-recipient_contact_person" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_contact_person_phone"><span data-toggle="tooltip" title="<?php echo $help_recipient_contact_person_phone; ?>"><?php echo $entry_phone; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_recipient_contact_person_phone" value="<?php echo $novaposhta_recipient_contact_person_phone; ?>" placeholder="<?php echo $entry_phone; ?>" id="input-recipient_contact_person_phone" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_area"><span data-toggle="tooltip" title="<?php echo $help_recipient_area; ?>"><?php echo $entry_area; ?></span></label>
            					<div class="col-sm-10">
              						<input type="text" name="novaposhta_recipient_area" value="<?php echo $novaposhta_recipient_area; ?>" placeholder="<?php echo $entry_area; ?>" id="input-recipient_area" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_city"><span data-toggle="tooltip" title="<?php echo $help_recipient_city; ?>"><?php echo $entry_city; ?></span></label>
            					<div class="col-sm-10">
              						<input type="text" name="novaposhta_recipient_city" value="<?php echo $novaposhta_recipient_city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-recipient_city" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_warehouse"><span data-toggle="tooltip" title="<?php echo $help_recipient_warehouse; ?>"><?php echo $entry_warehouse; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_recipient_warehouse" value="<?php echo $novaposhta_recipient_warehouse; ?>" placeholder="<?php echo $entry_warehouse; ?>" id="input-recipient_warehouse" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-recipient_address"><span data-toggle="tooltip" title="<?php echo $help_recipient_address; ?>"><?php echo $entry_address; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_recipient_address" value="<?php echo $novaposhta_recipient_address; ?>" placeholder="<?php echo $entry_address; ?>" id="input-recipient_address" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-preferred_delivery_date"><span data-toggle="tooltip" title="<?php echo $help_preferred_delivery_date; ?>"><?php echo $entry_preferred_delivery_date; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_preferred_delivery_date" value="<?php echo $novaposhta_preferred_delivery_date; ?>" placeholder="<?php echo $entry_preferred_delivery_date; ?>" id="input-preferred_delivery_date" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-preferred_delivery_time"><span data-toggle="tooltip" title="<?php echo $help_preferred_delivery_time; ?>"><?php echo $entry_preferred_delivery_time; ?></span></label>
            					<div class="col-sm-10">
            						<input type="text" name="novaposhta_preferred_delivery_time" value="<?php echo $novaposhta_preferred_delivery_time; ?>" placeholder="<?php echo $entry_preferred_delivery_time; ?>" id="input-preferred_delivery_time" class="form-control" />
              					</div>
              				</div>
          				</div>
          				<div class="tab-pane fade" id="tab-departure">
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-departure_type"><span data-toggle="tooltip" title="<?php echo $help_departure_type; ?>"><?php echo $entry_departure_type; ?></span></label>
            					<div class="col-sm-10">
            						<select name="novaposhta_departure_type" id="input-departure_type" class="form-control">
                						<?php foreach ($cargo_types as $v) { ?>
                							<?php if ($v['Ref'] == $novaposhta_departure_type) { ?>
                						<option value="<?php echo $v['Ref']; ?>" selected="selected"><?php echo $v['Description']; ?></option>
                							<?php } else { ?>
                						<option value="<?php echo $v['Ref']; ?>"><?php echo $v['Description']; ?></option>
               								<?php } ?>
                						<?php } ?>
              						</select>
              					</div>
              				</div>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-departure_description"><span data-toggle="tooltip" title="<?php echo $help_departure_description; ?>"><?php echo $entry_departure_description; ?></span></label>
            					<div class="col-sm-10">
              						<input type="text" name="novaposhta_departure_description" value="<?php echo $novaposhta_departure_description; ?>" placeholder="<?php echo $entry_departure_description; ?>" id="input-departure_description" class="form-control" />
              					</div>
              				</div>
              				<div class="form-group">	
			          			<label class="col-sm-2 control-label" for="input-additional_information"><span data-toggle="tooltip" title="<?php echo $help_additional_information; ?>"><?php echo $entry_additional_information; ?></span></label>
			            		<div class="col-sm-10">
			            			<textarea name="novaposhta_additional_information" rows="4" id="input-additional_information" class="form-control"><?php echo $novaposhta_additional_information; ?></textarea>
			          			</div>
			          			<div class="col-sm-4" id="additional_information_t_v" style="display: none;">
			          				<div class="well">
  										<button type="button" id="additional_information_t_v" class="close"><span aria-hidden="true">&times;</span></button>
  										<?php echo $text_order_template_macro; ?><br/><?php echo $text_products_template_macro; ?>
									</div>
			          			</div>
			          		</div>
			          		<div class="form-group">
			            		<label class="col-sm-2 control-label" for="input-announced_price"><span data-toggle="tooltip" title="<?php echo $help_announced_price; ?>"><?php echo $entry_announced_price; ?></span></label>
			            		<div class="col-sm-10">
			            			<div class="well well-sm" style="height: 160px; overflow: auto;">
			            			<?php if (is_array($totals)) { ?>
			            				<?php foreach ($totals as $code => $title) { ?>
			            				<div class="checkbox">
			            					<label>
			            					<?php if (in_array($code, $novaposhta_announced_price)) { ?>
			            						<input type="checkbox" name="novaposhta_announced_price[]" value="<?php echo $code; ?>" checked="checked" /> <?php echo $title; ?>
			            					<?php } else { ?>
			            						<input type="checkbox" name="novaposhta_announced_price[]" value="<?php echo $code; ?>" /> <?php echo $title; ?>
			            					<?php } ?>
			            					</label>
			            				</div>
			            				<?php } ?>
			            			<?php } ?>
			            			</div>
			            		</div>
			            	</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-weight"><span data-toggle="tooltip" title="<?php echo $help_weight; ?>"><?php echo $entry_weight; ?></span></label>
            					<div class="col-sm-10">
            						<div class="input-group">
              							<input type="text" name="novaposhta_weight" value="<?php echo $novaposhta_weight; ?>" placeholder="<?php echo $entry_weight; ?>" id="input-weight" class="form-control" />
              							<span class="input-group-addon"><?php echo $text_kg; ?></span>
              						</div>
              					</div>
              				</div>
              				<div class="form-group">	
              					<label class="col-sm-2 control-label" for="input-dimensions"><span data-toggle="tooltip" title="<?php echo $help_dimensions; ?>"><?php echo $entry_dimensions; ?></span></label>
            					<div class="col-sm-3">
            						<div class="input-group">
              							<input type="text" name="novaposhta_dimensions_w" value="<?php echo $novaposhta_dimensions_w; ?>" placeholder="0" id="input-dimensions" class="form-control" />
              							<span class="input-group-addon"><?php echo $text_cm; ?></span>
              						</div>
            					</div>
            					<div class="col-sm-4">
            						<div class="input-group">
              							<input type="text" name="novaposhta_dimensions_l" value="<?php echo $novaposhta_dimensions_l; ?>" placeholder="0" id="input-dimensions" class="form-control" />
              							<span class="input-group-addon"><?php echo $text_cm; ?></span>
              						</div>
            					</div>
            					<div class="col-sm-3">
            						<div class="input-group">
	              						<input type="text" name="novaposhta_dimensions_h" value="<?php echo $novaposhta_dimensions_h; ?>" placeholder="0" id="input-dimensions" class="form-control" />
	              						<span class="input-group-addon"><?php echo $text_cm; ?></span>
              						</div>
            					</div>
          					</div>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-calculate_volume"><span data-toggle="tooltip" title="<?php echo $help_calculate_volume; ?>"><?php echo $entry_calculate_volume; ?></span></label>
            					<div class="col-sm-10">
            						<div class="btn-group" data-toggle="buttons">
	      							<?php if ($novaposhta_calculate_volume) { ?>
						                <label class="btn btn-default" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_calculate_volume" value="0"><?php echo $text_no; ?></label>
	      								<label class="btn btn-success active" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_calculate_volume" value="1" id="input-calculate_volume" checked><?php echo $text_yes; ?></label>
						                <?php } else { ?>
						                <label class="btn btn-danger active" data-onstyle="btn-danger" data-offstyle="btn-default"><input type="radio" name="novaposhta_calculate_volume" value="0" checked><?php echo $text_no; ?></label>
	      								<label class="btn btn-default" data-onstyle="btn-success" data-offstyle="btn-default"><input type="radio" name="novaposhta_calculate_volume" value="1" id="input-calculate_volume"><?php echo $text_yes; ?></label>
						            <?php } ?>                    				
									</div>
            					</div>
            				</div>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-use_parameters"><span data-toggle="tooltip" title="<?php echo $help_use_parameters; ?>"><?php echo $entry_use_parameters; ?></span></label>
            					<div class="col-sm-10">
            						<select name="novaposhta_use_parameters" id="input-use_parameters" class="form-control">
                					<?php foreach ($use_parameters as $k => $n) { ?>
                						<?php if ($k == $novaposhta_use_parameters) { ?>
                						<option value="<?php echo $k; ?>" selected="selected"><?php echo $n; ?></option>
                						<?php } else { ?>
                						<option value="<?php echo $k; ?>"><?php echo $n; ?></option>
               							<?php } ?>
                					<?php } ?>
              						</select>
            					</div>
            				</div>	
          				</div>
          				<div class="tab-pane fade" id="tab-cron">
          					<div class="alert alert-info" role="alert"><?php echo $text_cron; ?></div>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-key_cron"><span data-toggle="tooltip" title="<?php echo $help_key_cron; ?>"><?php echo $entry_key_cron; ?></span></label>
            					<div class="col-sm-10">
    								<div class="input-group">
    									<input type="text" name="novaposhta_key_cron" value="<?php echo $novaposhta_key_cron; ?>" placeholder="<?php echo $entry_key_cron; ?>" id="input-key_cron" class="form-control" />
    									<span class="input-group-btn">
    										<button id="generate-key" onclick="generateKey();" type="button" class="btn btn-info" data-toggle="tooltip" title="<?php echo $button_generate; ?>"><i class="fa fa-cog"></i></button>
    									</span>
    								</div>	
    							</div>
              				</div>
          					<legend><?php echo $text_base_update; ?></legend>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-cron_update_areas"><?php echo $entry_update_areas; ?></label>
            					<div class="col-sm-10">
              						<input type="text" value="<?php echo $cron_update_areas; ?>"  id="input-cron_update_areas" class="form-control" readonly />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-cron_update_cities"><?php echo $entry_update_cities; ?></label>
            					<div class="col-sm-10">
              						<input type="text" value="<?php echo $cron_update_cities; ?>"  id="input-cron_update_cities" class="form-control" readonly />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-cron_update_warehouses"><?php echo $entry_update_warehouses; ?></label>
            					<div class="col-sm-10">
              						<input type="text" value="<?php echo $cron_update_warehouses; ?>"  id="input-cron_update_warehouses" class="form-control" readonly />
              					</div>
              				</div>
              				<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-cron_update_references"><?php echo $entry_update_references; ?></label>
            					<div class="col-sm-10">
              						<input type="text" value="<?php echo $cron_update_references; ?>"  id="input-cron_update_references" class="form-control" readonly />
              					</div>
              				</div>
              				<legend><?php echo $text_departures_tracking; ?></legend>
          					<div class="form-group">
            					<label class="col-sm-2 control-label" for="input-cron_departures_tracking"><?php echo $entry_departures_tracking; ?></label>
            					<div class="col-sm-10">
              						<input type="text" value="<?php echo $cron_departures_tracking; ?>"  id="input-cron_departures_tracking" class="form-control" readonly />
              					</div>
              				</div>
              				<div class="form-group">
					        	<label class="col-sm-2 control-label" for="input-tracking_statuses"><span data-toggle="tooltip" title="<?php echo $help_tracking_statuses; ?>"><?php echo $entry_tracking_statuses; ?></span></label>
					        	<div class="col-sm-10">
					        		<div class="well well-sm" style="height: 200px; overflow: auto;">
					        			<?php foreach ($order_statuses as $order_status) { ?>
					        			<div class="checkbox">
					        				<label>
					        				<?php if (is_array($novaposhta_tracking_statuses) && in_array($order_status['order_status_id'], $novaposhta_tracking_statuses)) { ?>
					        					<input type="checkbox" name="novaposhta_tracking_statuses[]" value="<?php echo $order_status['order_status_id']; ?>" checked="checked" /><?php echo $order_status['name']; ?>
					        				<?php } else { ?>
					        					<input type="checkbox" name="novaposhta_tracking_statuses[]" value="<?php echo $order_status['order_status_id']; ?>" /><?php echo $order_status['name']; ?>
					        				<?php } ?>
					        				</label>
					        			</div>
					        			<?php } ?>
					        		</div>
					        	</div>
					        </div>
					        <div class="panel panel-default">
					        	<div class="panel-heading" role="tab" id="headingOne">
					        		<h4 class="panel-title">
					        			<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"><p class="text-primary"><?php echo $text_message_template_macro; ?> <span class="caret"></span></p></a>
					        		</h4>
					        	</div>
					        	<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
					        		<div class="panel-body">
					        			<div class="col-sm-4">
					        				<?php echo $text_ei_template_macro; ?>
					        			</div>
					        			<div class="col-sm-4">
					        				<?php echo $text_order_template_macro; ?>
					        			</div>
					        			<div class="col-sm-4">
					        				<?php echo $text_products_template_macro; ?>
					        			</div>
					        		</div>
					        	</div>
					        </div>
					        <div class="panel panel-default">
							    <div class="panel-heading"><h3><?php echo $text_settings_departures_statuses; ?></h3></div>
								<div class="table-responsive">
					            	<table class="table table-bordered table-hover" id="table-tracking_statuses">
					              		<thead>
					                		<tr>
					                  			<td class="text-center"><?php echo $column_novaposhta_status; ?></td>
					                  			<td class="text-center"><?php echo $column_store_status; ?></td>
					                  			<td class="text-center"><?php echo $column_notification; ?></td>
					                  			<td class="text-center" width="30%"><?php echo $column_message; ?></td>
					                  			<td class="text-center"><?php echo $column_action; ?></td>
					                		</tr>
					              		</thead>
					              		<tbody>
					              		<?php if (is_array($novaposhta_settings_tracking_statuses)) { ?>
					              			<?php foreach ($novaposhta_settings_tracking_statuses as $i => $settings) { ?>
					              			<tr>
					                  			<td>
					                  				<select name="novaposhta_settings_tracking_statuses[<?php echo $i; ?>][novaposhta]" id="novaposhta-status" class="form-control">
					                  				<?php foreach ($document_statuses as $document_status) { ?>
					                  					<?php if ($document_status['StateId'] == $settings['novaposhta']) { ?>
					                  					<option value="<?php echo $document_status['StateId']; ?>" selected="selected"><?php echo $document_status['StateName']; ?></option>
					                  					<?php } else { ?>
					                  					<option value="<?php echo $document_status['StateId']; ?>"><?php echo $document_status['StateName']; ?></option>
					                  					<?php } ?>
					                  				<?php } ?>
					                  				</select>
					                  			</td>
					                  			<td>
					                  				<select name="novaposhta_settings_tracking_statuses[<?php echo $i; ?>][store]" id="store-status" class="form-control">
					                  				<?php foreach ($order_statuses as $order_status) { ?>
					                  					<?php if ($order_status['order_status_id'] == $settings['store']) { ?>
					                  					<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
					                  					<?php } else { ?>
					                  					<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
					                  					<?php } ?>
					                  				<?php } ?>
					                  				</select>
					                  			</td>
					                  			<td>
					                  				<label class="control-label" for="customer-notification"><?php echo $entry_customer_notification; ?></label> <input type="checkbox" name="novaposhta_settings_tracking_statuses[<?php echo $i; ?>][customer_notification]" id="customer-notification" <?php echo (isset($settings['customer_notification'])) ? 'checked' : '';?>><br/>
					                  				<label class="control-label" for="admin-notification"><?php echo $entry_admin_notification; ?></label> <input type="checkbox" name="novaposhta_settings_tracking_statuses[<?php echo $i; ?>][admin_notification]" id="admin-notification" <?php echo (isset($settings['admin_notification'])) ? 'checked' : '';?>>
					                  				
					                  			</td>
					                  			<td>
					                  				<textarea name="novaposhta_settings_tracking_statuses[<?php echo $i; ?>][message]" rows="4" id="message" class="form-control"><?php echo $settings['message']; ?></textarea>
					                  			</td>
					                  			<td class="text-center"><button type="button" onclick="$(this).parents('tr').remove()" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
					                		</tr>
					                		<?php } ?>
					                	<?php } ?>
					              		</tbody>
					              		<tfoot>
					              			<tr>
					              				<td colspan="4"></td>
					              				<td class="text-center"><button type="button" onclick="addTrackingStatus();" data-toggle="modal" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
					              			</tr>
					              		</tfoot>
					            	</table>
					          	</div>
				          	</div>
          				</div>
          				<?php } ?>
          				<div class="tab-pane fade<?php if (!$license) { ?>in active<?php } ?>" id="tab-support">
          					<?php echo $ocmax; ?>			
          				</div>
          			</div>
          			<!-- Modal API key-->
					<div class="modal fade" id="APIKey" tabindex="-1" role="dialog" aria-labelledby="APIKeyLabel">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      	<div class="modal-header">
						        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        	<h4 class="modal-title" id="APIKeyLabel"><?php echo $heading_applying_api_key; ?></h4>
						      	</div>
							    <div class="modal-body">
				          			<div class="well" id="API_key_log"></div>
				          			<p class="text-center"><i class="fa fa-cog fa-spin fa-3x text-primary" id="API_key_applying_icon"></i></p>
							    </div>
							    <div class="modal-footer">
									<button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check"></i></button>
							    </div>
						    </div>
						</div>
					</div>         
				    <!-- Modal API key end-->
				    <!-- Modal tariffs-->
					<div class="modal fade" id="editTariff" tabindex="-1" role="dialog" aria-labelledby="editTariffLabel">
						  <div class="modal-dialog modal-lg" role="document">
						    <div class="modal-content">
						      	<div class="modal-header">
						        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						        	<h4 class="modal-title" id="editTariffLabel"><?php echo $heading_tariff; ?></h4>
						      	</div>
							    <div class="modal-body">
							      	<div class="form-group">
				            			<label class="col-sm-3 control-label" for="input-discount"><span data-toggle="tooltip" title="<?php echo $help_discount; ?>"><?php echo $entry_discount; ?></span></label>
				            			<div class="col-sm-9">
					            			<div class="input-group">
				              					<input type="text" name="novaposhta_tariffs[discount]" value="<?php echo $novaposhta_tariffs['discount']; ?>" placeholder="<?php echo $entry_discount; ?>" id="input-discount" class="form-control" />
				              					<span class="input-group-addon"><?php echo $text_pct; ?></span>
				              				</div>
			              				</div>
				          			</div>
				          			<div class="form-group">
				            			<label class="col-sm-3 control-label" for="input-additional_commission"><span data-toggle="tooltip" title="<?php echo $help_additional_commission; ?>"><?php echo $entry_additional_commission; ?></span></label>
				            			<div class="col-sm-3">
					            			<div class="input-group">
				              					<input type="text" name="novaposhta_tariffs[additional_commission]" value="<?php echo $novaposhta_tariffs['additional_commission']; ?>" placeholder="<?php echo $entry_additional_commission; ?>" id="input-additional_commission" class="form-control" />
				              					<span class="input-group-addon"><?php echo $text_pct; ?></span>
				              				</div>
			              				</div>
			              				<label class="col-sm-3 control-label" for="input-additional_commission_bottom"><span data-toggle="tooltip" title="<?php echo $help_additional_commission_bottom; ?>"><?php echo $entry_additional_commission_bottom; ?></span></label>
				            			<div class="col-sm-3">
					            			<div class="input-group">
				              					<input type="text" name="novaposhta_tariffs[additional_commission_bottom]" value="<?php echo $novaposhta_tariffs['additional_commission_bottom']; ?>" placeholder="<?php echo $entry_additional_commission_bottom; ?>" id="input-additional_commission_bottom" class="form-control" />
				              					<span class="input-group-addon"><?php echo $text_grn; ?></span>
				              				</div>
			              				</div>
				          			</div>
				          			<legend><?php echo $text_parcel_tariffs; ?></legend>
				          			<div class="form-group">
				            			<label class="col-sm-3 control-label" for="input-overpay_doors_warehouse"><span data-toggle="tooltip" title="<?php echo $help_overpay_doors_warehouse; ?>"><?php echo $entry_overpay_doors_warehouse; ?></span></label>
				            			<div class="col-sm-3">
					            			<div class="input-group">
				              					<input type="text" name="novaposhta_tariffs[parcel][overpay_doors_warehouse]" value="<?php echo $novaposhta_tariffs['parcel']['overpay_doors_warehouse']; ?>" placeholder="<?php echo $entry_overpay_doors_warehouse; ?>" id="input-overpay_doors_warehouse" class="form-control" />
				              					<span class="input-group-addon"><?php echo $text_pct; ?></span>
				              				</div>
			              				</div>
			              				<label class="col-sm-3 control-label" for="input-overpay_doors_doors"><span data-toggle="tooltip" title="<?php echo $help_overpay_doors_doors; ?>"><?php echo $entry_overpay_doors_doors; ?></span></label>
				            			<div class="col-sm-3">
					            			<div class="input-group">
				              					<input type="text" name="novaposhta_tariffs[parcel][overpay_doors_doors]" value="<?php echo $novaposhta_tariffs['parcel']['overpay_doors_doors']; ?>" placeholder="<?php echo $entry_overpay_doors_doors; ?>" id="input-overpay_doors_doors" class="form-control" />
				              					<span class="input-group-addon"><?php echo $text_grn; ?></span>
				              				</div>
			              				</div>
				          			</div>
									<div class="table-responsive">
					            		<table class="table table-bordered table-hover" id="table-tariffs">
					              			<thead>
					                			<tr>
					                  				<td class="text-center" rowspan="2"><?php echo $column_weight; ?></td>
					                  				<td class="text-center"><?php echo $column_service_cost; ?></td>
					                  				<td class="text-center" rowspan="2" width="100px"><?php echo $column_action; ?></td>
					                			</tr>
					                			<tr>
					                  				<td class="text-center"><?php echo $column_tariff_zone_ukraine; ?></td>
					                			</tr>
					              			</thead>
					              			<tbody>
					              			<?php if (isset($novaposhta_tariffs['parcel']['tariffs'])) { $count = 0;?>
					              				<?php foreach ($novaposhta_tariffs['parcel']['tariffs'] as $tariff) { ?>
					              				<tr>
					                  				<td><div class="input-group"><input type="text" name="novaposhta_tariffs[parcel][tariffs][<?php echo $count; ?>][weight]" value="<?php echo $tariff['weight']; ?>" id="tariff-weight" class="form-control" /><span class="input-group-addon"><?php echo $text_kg; ?></span></div></td>
					                  				<td><div class="input-group"><input type="text" name="novaposhta_tariffs[parcel][tariffs][<?php echo $count; ?>][Ukraine]" value="<?php echo $tariff['Ukraine']; ?>" id="tariff-uk" class="form-control" /><span class="input-group-addon"><?php echo $text_grn; ?></span></div></td>
					                  				<td><div class="btn-group" role="group"><button type="button" onclick="$(this).parents('tr').find('input').val('')" class="btn btn-default"><i class="fa fa-eraser"></i></button><button type="button" onclick="$(this).parents('tr').remove()" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></div></td>
					                			</tr>
					                			<?php $count++; } ?>
					                		<?php } ?>
					              			</tbody>
					              			<tfoot>
					              				<tr>
													<td colspan="2"></td>
													<td class="text-center"><button type="button" onclick="addTariff('parcel')" data-toggle="modal" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
													</td>
												</tr>
											</tfoot>
					            		</table>
					          		</div>
							    </div>
							    <div class="modal-footer">
									<button type="submit" class="btn btn-primary" onclick="save();"><i class="fa fa-check"></i></button>
									<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i></button>
							    </div>
						    </div>
						</div>
					</div>         
				    <!-- Modal tariff end-->
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
			checked = '<?php echo $novaposhta_sender_contact_person; ?>';
			sender = $('#input-sender').val();
			
		break;
		
		case 'sender_address':
			action = 'getAddress';
			checked = '<?php echo $novaposhta_sender_address; ?>';
			sender = $('#input-sender').val();
			city = $('input[name = novaposhta_sender_city_name]').val();
			
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
	    
function update(type) {
	$.ajax( {
		url: 'index.php?route=extension/shipping/novaposhta/update&type=' + type + '&token=<?php echo $token; ?>',
		dataType: 'json',
		beforeSend: function () {
			$('.alert').remove();
			$('#button-update_' + type + ' > i').addClass('fa-spin');
		},
		success: function (json) {
			if(json['success']) {
				$('.container-fluid:eq(1)').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				var diff = json['amount'] - $('#' + type + 'amount').text();
				if (diff > 0) {
					$('#' + type + 'amount').append(' <strong><font color="green">+' + diff + '</font></strong>');
				} else if (diff < 0) {
					$('#' + type + 'amount').append(' <strong><font color="red">' + diff + '</font></strong>');
				}
			}
			
			if(json['error']) {
				$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
			}
			
			$('html, body').animate({ scrollTop: 0 }, 'slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		},
		complete: function () {
			$('#button-update_' + type + ' > i').removeClass('fa-spin');
		}
	} );
}

function addTariff(tariff_name) {
	var count = $('#table-tariffs tbody tr').length + 1;
	var row = '<tr>';
	
	row += '<td><div class="input-group"><input type="text" name="novaposhta_tariffs[' + tariff_name + '][tariffs][' + count + '][weight]" value="" id="tariff-weight" class="form-control" /><span class="input-group-addon"><?php echo $text_kg; ?></span></div></td>';
	row += '<td><div class="input-group"><input type="text" name="novaposhta_tariffs[' + tariff_name + '][tariffs][' + count + '][Ukraine]" value="" id="tariff-ww" class="form-control" /><span class="input-group-addon"><?php echo $text_grn; ?></span></div></td>';
	row += '<td><div class="btn-group" role="group"><button type="button" onclick="$(this).parents(\'tr\').find(\'input\').val(\'\')" class="btn btn-default"><i class="fa fa-eraser"></i></button><button type="button" onclick="$(this).parents(\'tr\').remove()" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></div></td>';
	row += '</tr>';
		
	$('#table-tariffs tbody').append(row);
}

function addTrackingStatus() {
	var row = '<tr>';
	
	row += '<td><select name="novaposhta_settings_tracking_statuses[0][novaposhta]" id="novaposhta-status" class="form-control"><?php foreach ($document_statuses as $document_status) { ?><option value="<?php echo $document_status["StateId"]; ?>"><?php echo $document_status["StateName"]; ?></option><?php } ?></select></td>';
	row += '<td><select name="novaposhta_settings_tracking_statuses[0][store]" id="store-status" class="form-control"><?php foreach ($order_statuses as $order_status) { ?><option value="<?php echo $order_status["order_status_id"]; ?>"><?php echo $order_status["name"]; ?></option><?php } ?></select></td>';
	row += '<td><label class="control-label" for="customer-notification"><?php echo $entry_customer_notification; ?></label> <input type="checkbox" name="novaposhta_settings_tracking_statuses[0][customer_notification]" id="customer-notification"><br/><label class="control-label" for="admin-notification"><?php echo $entry_admin_notification; ?></label> <input type="checkbox" name="novaposhta_settings_tracking_statuses[0][admin_notification]" id="admin-notification"></td>';
	row += '<td><textarea name="novaposhta_settings_tracking_statuses[0][message]" rows="4" id="message" class="form-control"></textarea></td>';
	row += '<td class="text-center"><button type="button" onclick="$(this).parents(\'tr\').remove()" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	row += '</tr>';
		
	$('#table-tracking_statuses tbody').append(row);
}

function generateKey() {
	$.ajax({
		url: 'index.php?route=extension/shipping/novaposhta/generateKey&token=<?php echo $token; ?>',
		dataType: 'json',
		beforeSend: function () {
			$('#generate-key > i').addClass('fa-spin');
		},
		success: function (json) {
			if (json['code']) {
				$('input#input-key_cron').val(json['code'])
			}
		},
		complete: function () {
			$('#generate-key > i').removeClass('fa-spin');
		}
	});
}

function save() {
	$.ajax( {
		url: 'index.php?route=extension/shipping/novaposhta&token=<?php echo $token; ?>',
		type: 'POST',
		data: $('#form-novaposhta').serialize(),
		beforeSend: function() {
	   		$('#form-novaposhta').fadeTo('slow', 0.5);
	  	},
		complete: function () {
			location.reload();
		}
	} );
}

$(function() {
	// Load sender data
	$('#input-sender').on('change', function () {		
		getNPData('sender_contact_person');
	});
	
	$('input[name = novaposhta_sender_city]').on('change', function () {		
		getNPData('sender_address');
	});
	
	$('#input-sender_address').on('change', function (e) {		
		
		$.ajax( {
			url: 'index.php?route=extension/shipping/novaposhta/getNPData&token=<?php echo $token; ?>',
			type: 'POST',
			data: 'action=getAddressType&address=' + encodeURIComponent(e.target.value),
			dataType: 'json',
			success: function (json) {
				$('input[name = novaposhta_sender_address_type]').val(json['address_type']);
			}
		} );
	} );
	
	//  Applying API key
	$('#input-key_api').on('change', function (e) {
		var key_api = e.target.value;
		
		$('#APIKey').modal('show');
		
		$('#API_key_applying_icon').addClass('fa-spin');
		$('#API_key_log').empty().append('<p><?php echo $text_key_api_checking; ?> <i class="fa fa-circle-o-notch fa-spin"></i></p>');
		
		function action(act) {
			$.ajax( {
				url: 'index.php?route=extension/shipping/novaposhta/applyAPIkey&token=<?php echo $token; ?>',
				type: 'POST',
				data: 'action=' + act + '&key=' + key_api,
				dataType: 'json',
				success: function(json) {
					if (json['error']) {
						$('#API_key_log').find('i').replaceWith('<i class="fa fa-exclamation-circle text-danger"></i>');
						$('#API_key_applying_icon').removeClass('fa-spin');
						
						for(var e in json['error']) {			
							$('#API_key_log').append('<p class="text-danger">' + json['error'][e] + '</p>');
						}
					}
					
					if (json['next_action']) {
						$('#API_key_log').find('i').replaceWith('<i class="fa fa-check text-success" aria-hidden="true"></i>');
						$('#API_key_log').append('<p>' + json['next_action_text'] + ' <i class="fa fa-circle-o-notch fa-spin"></i></p>');

						if (json['next_action'] == 'saving') {
							$('#API_key_applying_icon').removeClass('fa-spin');
							
							setTimeout(function() { 
									$('#APIKey').modal('hide'); 
									save();
								},
								2000
							);
						} else {
							action(json['next_action']);
						}	
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
						
			} );
		}
		
		action('check');
	} );
	
	// Edit tariffs
	$('#button-tariff').on('click', function () {
		$('#editTariff').modal('show');
	});
	
	// Show/hide macros of additional information
	$('#input-additional_information').on('focus', function () {
		$(this).parent().removeClass('col-sm-10').addClass('col-sm-6');
		$('div#additional_information_t_v').fadeIn();
	} );
	
	$('button#additional_information_t_v').on('click', function () {
		$('div#additional_information_t_v').hide();
		$('#input-additional_information').parent().removeClass('col-sm-6').addClass('col-sm-10');
	} );
	
	// Search city
	$('input[name = novaposhta_sender_city_name]').autocomplete( {
		source: function(request, response) {
			var post_data = 'city=' + encodeURIComponent(request);
			
			$.ajax( {
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'POST',
				data: post_data,
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['Description'],
							value: item['CityName'],
							city_ref: item['CityRef']
						}
					}));
				}
			} );
		},
		select: function(item) {
			$(this).val(item['value']);
			$('input[name = novaposhta_sender_city]').val(item['city_ref']).trigger('change');
		}
	} );
	
	// Search recipient
	$('input[name = novaposhta_recipient_name]').autocomplete( {
		source: function(request, response) {
			var post_data = 'recipient_name=' + encodeURIComponent(request);
			
			$.ajax({
				url: 'index.php?route=extension/shipping/novaposhta/autocomplete&token=<?php echo $token; ?>',
				type: 'POST',
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
			$(this).val(item['value']);
		}
	} );
	
	// Set index
	$('table#table-tracking_statuses').on('change', 'select#novaposhta-status', function(e) {
		var np_status_id = e.target.value;

		$(e.target).parents('tr').find('#novaposhta-status, #store-status, #customer-notification, #admin-notification, #message').each(function (i, e) { 
			$(e).attr('name', function () { 
				return this.name.replace(/^(\w+)\[.*?\]/, '$1[' + np_status_id + ']');
			} );
		} );
	} );
	
	// Input radio toggle
	$('label.btn:has(input[type = radio])').on('click', function(e) {
		var c = $(e.currentTarget), s = c.siblings(), c_onstyle = c.attr('data-onstyle'), s_onstyle = s.attr('data-onstyle'), c_offstyle = c.attr('data-offstyle'), s_offstyle = s.attr('data-offstyle');
		
		if (!c.hasClass('active')) {
			c.removeClass(c_offstyle).addClass(c_onstyle);
			s.removeClass(s_onstyle).addClass(c_offstyle);
		}
	} );
});
//--></script>     
<?php echo $footer; ?> 