<div id="popup-callback" class="wcb-4">
	<div class="popup-heading"><i class="<?php echo $callbackpro['icon_callbackpro_header'];?>"></i>&nbsp;&nbsp;<?php echo isset($callbackpro['title_callback'][$lang_id]) ? $callbackpro['title_callback'][$lang_id]['text'] : ''; ?></div>
	<div class="popup-center">
	<?php if(isset($callbackpro['config_on_off_contact_right'])) {?>
		<div id="callbackpro_contacts">
			<div class="contacts-content">
				<div class="col-xs-6">
					<div class="telephone">
						<?php foreach ($config_telephones as $result) { ?>
							<div><a href="tel:<?php echo $result['phone'];?>">
							<?php if($result['phone'] !='') { ?>
								<?php if($result['thumb'] !='') { ?><img src="<?php echo $result['thumb'];?>" />&nbsp;&nbsp;<?php } ?><?php echo $result['phone'];?></a></div>
							<?php } ?>
						<?php } ?>
					</div>
					<?php if ($callbackpro['config_email_1'] !='') { ?>
						<div class="email">
							<div><i class="fa fa-envelope fa-fw"></i>&nbsp;<?php echo $callbackpro['config_email_1']; ?></div>					
						</div>					
					<?php } ?>
				</div>
				<div class="col-xs-6">
					<?php if ($callbackpro['skype'] !='') { ?>
						<?php if(isset($callbackpro['show_status_skype'])){?>
							<?php $timenow = date("H:i");?>
							<?php if(($timenow > $callbackpro['skype_date_start']) && ($timenow < $callbackpro['skype_date_end'])) { ?>
								<div class="skype">
									<a class="status_skype" href="skype:?chat"><img src="catalog/view/theme/default/image/skype_online.png">&nbsp;<?php echo $callbackpro['skype']; ?></a>
								</div>
							<?php } else { ?>
								<div class="skype">
									<a class="status_skype" href="skype:?chat"><img src="catalog/view/theme/default/image/skype_offline.png">&nbsp;<?php echo $callbackpro['skype']; ?></a>
								</div>
							<?php } ?>
						<?php } else { ?>
							<div class="skype">
								<a class="status_skype" href="skype:?chat"><img src="catalog/view/theme/default/image/skype_offline.png">&nbsp;<?php echo $callbackpro['skype']; ?></a>
							</div>
						<?php } ?>
					<?php } ?>
					<div class="schedule">				
						<div class="title-schedule"><?php echo isset($callbackpro['title_schedule'][$lang_id]) ? $callbackpro['title_schedule'][$lang_id]['text'] : ''; ?></div>
						<div class="config_daily">
							<?php echo isset($callbackpro['daily'][$lang_id]) ? $callbackpro['daily'][$lang_id]['text'] : ''; ?>
						</div>
						<div class="config_weekend">
							<?php echo isset($callbackpro['weekend'][$lang_id]) ? $callbackpro['weekend'][$lang_id]['text'] : ''; ?>
						</div>
					</div>					
				</div>
				<div class="col-xs-12">
					<?php if ($social_icons_contact) { ?>
						<div class="col-sm-12 line_cb"></div>
						<div class="title-social"><?php echo isset($callbackpro['config_social_block_title'][$lang_id]) ? $callbackpro['config_social_block_title'][$lang_id]['config_social_block_title'] : ''; ?></div>
						<div class="social">
							<?php foreach($social_icons_contact as $result) { ?>
								<div class="social-icon"><a href="<?php echo $result['name']; ?>" target="_blank"><img src="<?php echo $result['thumb']; ?>"/></a></div>
							<?php } ?>
						</div>
					<?php } ?>
				</div>
			</div>
			<div class="contact-open">
				<a onclick="$('#callbackpro_contacts').toggleClass('callbackpro_contacts_open');"><i class="fa fa-phone"></i>&nbsp;&nbsp;<?php echo isset($callbackpro['block_name_phone'][$lang_id]) ? $callbackpro['block_name_phone'][$lang_id]['block_name_phone'] : ''; ?></a>
			</div>
		</div>
		<?php } ?>
	<form id="callback_data" data-ajax-submit enctype="multipart/form-data" method="post">
		<?php if ($main_image_callback != '') { ?>
		<div class="col-xs-12 hidden-xs">			
			<div class="text-center marb"><img class="circular img-phone-contact" src="<?php echo $main_image_callback; ?>"/></div>			
		</div>
		<?php } ?>
		<div class="col-xs-12">
			<?php if(isset($callbackpro['config_on_off_fields_firstname_cb'])) { ?>
				<div class="form-group <?php echo isset($callbackpro['config_fields_firstname_requared_cb']) ? 'sections_block_rquaired' : 'sections_block' ; ?>">
					<div class="input-group margin-bottom-sm">			
						 <input id="contact-name" class="form-control contact-name" type="text" placeholder="<?php echo $callbackpro['config_placeholder_fields_firstname_cb'][$lang_id]['config_placeholder_fields_firstname_cb']; ?>" value="" name="name">		
						<span class="input-group-addon"><i class="icon-append-1 fa fa-user fa-fw"></i></span>
					</div>
					<div id="error_name_callback" class="error_callback"></div>
				</div>
			<?php } ?>
			<?php if(isset($callbackpro['config_on_off_fields_phone_cb'])) { ?>
				<div class="form-group <?php echo isset($callbackpro['config_fields_phone_requared_cb']) ? 'sections_block_rquaired' : 'sections_block' ; ?>">
					<div class="input-group margin-bottom-sm">			
						 <input id="contact-phone" class="form-control contact-phone" type="text" placeholder="<?php echo $callbackpro['config_placeholder_fields_phone_cb'][$lang_id]['config_placeholder_fields_phone_cb']; ?>" value="" name="phone">		
						<span class="input-group-addon"><i class="icon-append-1 fa fa-phone-square fa-fw"></i></span>
					</div>
					<div id="error_phone_callback" class="error_callback"></div>
				</div>
			<?php } ?>
			<?php if(isset($callbackpro['config_on_off_fields_email_cb'])) { ?>
				<div class="form-group <?php echo isset($callbackpro['config_fields_email_requared_cb']) ? 'sections_block_rquaired' : 'sections_block' ; ?>">
					<div class="input-group margin-bottom-sm">			
						 <input id="contact-email" class="form-control contact-email" type="text" placeholder="<?php echo $callbackpro['config_placeholder_fields_email_cb'][$lang_id]['config_placeholder_fields_email_cb']; ?>" value="" name="email_buyer">		
						<span class="input-group-addon"><i class="icon-append-1 fa fa-envelope fa-fw"></i></span>
					</div>
					<div id="error_email_callback" class="error_callback"></div>
				</div>
			<?php } ?>
			<?php if(isset($callbackpro['config_on_off_fields_comment_cb'])) { ?>
				<div class="form-group <?php echo isset($callbackpro['config_fields_comment_requared_cb']) ? 'sections_block_rquaired' : 'sections_block' ; ?>">
					<div class="input-group margin-bottom-sm">			
						 <input id="contact-comment" class="form-control contact-comment" type="text" placeholder="<?php echo $callbackpro['config_placeholder_fields_comment_cb'][$lang_id]['config_placeholder_fields_comment_cb']; ?>" value="" name="comment_buyer">		
						<span class="input-group-addon"><i class="icon-append-1 fa fa-comment fa-fw"></i></span>
					</div>
					<div id="error_comment_callback" class="error_callback"></div>
				</div>
			<?php } ?>
			<?php if(isset($callbackpro['config_on_off_date_time'])) { ?>
				<div class="form-group">
					<input type="text" name="time_callback_on" value="" class="form-control start" placeholder="<?php echo $when_you_call_back;?>" />
					<input type="hidden" name="time_callback_off" value="" />
				</div>
			<?php } ?>
			 <?php if(!empty($call_topic_data)) {?>
			   <div class="marb">
					<select class="form-control" name="topic_callback_send">
						<?php foreach($call_topic_data as $res_call_topic) { ?>
							<option value="<?php echo $res_call_topic['name']?>"><?php echo $res_call_topic['name']?></option>
						<?php } ?>
					</select>	
			   </div>
			   <?php } ?> 
			<input type="hidden" id="callback_url" value="" name="url_site"  />	
		</div>
		
		
		<div class="anytext-callback marb col-xs-12 text-center"><?php echo isset($callbackpro['config_any_text_bottom_before_button'][$lang_id]) ? $callbackpro['config_any_text_bottom_before_button'][$lang_id]['config_any_text_bottom_before_button'] : ''; ?></div>
	</form>
	</div>
	<div class="popup-footer">
		<div class="col-xs-12 text-center">
		<button onclick="sendCallback();" type="submit" class="btn-callback ladda-button" data-style="expand-left"><span class="ladda-label"><?php echo $button_send; ?></span></button>
		</div>
	</div>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css"/> 
<script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
$('.start').datetimepicker({
	pickDate: true,
	minDate : moment(),
	pickTime: true
});
$(document).ready(function() {
	var ContactouterHeight = $('#callbackpro_contacts').outerHeight()-6;
	$(function(){$('#callbackpro_contacts').css({'top':-ContactouterHeight});});
	<?php if($callbackpro['config_mask_phone_number_cb'] !='') { ?>
		$("#contact-phone").mask('<?php echo $callbackpro['config_mask_phone_number_cb'];?>');
	<?php } ?>
});
</script>
</div>