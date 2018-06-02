<?php if (!$check_license) { ?>
<legend><?php echo $text_license_request; ?></legend>
<div class="alert alert-info" role="alert"><?php echo $text_about_license; ?></div>
<div class="form-group">
	<label class="col-sm-2 control-label" for="input-email"><span data-toggle="tooltip" title="<?php echo $help_email; ?>"><?php echo $entry_email; ?></span></label>
	<div class="col-sm-4">
		<input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
	</div>
	<label class="col-sm-2 control-label" for="input-domain"><span data-toggle="tooltip" title="<?php echo $help_domain; ?>"><?php echo $entry_domain; ?></span></label>
	<div class="col-sm-4">
		<input type="text" name="domain" value="<?php echo str_replace('www.', '', $_SERVER['SERVER_NAME']); ?>" id="input-domain" class="form-control" disabled/>
	</div>
</div>
<div class="form-group">	
	<label class="col-sm-2 control-label" for="input-market"><span data-toggle="tooltip" title="<?php echo $help_market; ?>"><?php echo $entry_market; ?></span></label>
	<div class="col-sm-4">
		<select name="market" id="input-market" class="form-control">
			<option value="opencartforum.com">opencartforum.com</option>
			<option value="liveopencart.ru">liveopencart.ru</option>
			<option value="shop.opencart-russia.ru">shop.opencart-russia.ru</option>
			<option value="livrenet.ru">livrenet.ru</option>
			<option value="opencart.com">opencart.com</option>
			<option value="oc-max.com">oc-max.com</option>
        </select>
    </div>
    <label class="col-sm-2 control-label" for="input-check"><span data-toggle="tooltip" title="<?php echo $help_check; ?>"><?php echo $entry_check; ?></span></label>
    <div class="col-sm-4">
        <input type="text" name="check" value="" placeholder="<?php echo $entry_check; ?>" id="input-check" class="form-control" />
    </div>
</div>
<div class="form-group">
    <div class="col-sm-12">
        <a onclick="purchase('send')" id="button-send-purchase" data-toggle="tooltip" title="" class="btn btn-info btn-block col-sm-6" data-original-title="<?php echo $help_send; ?>"><i class="fa fa-envelope-o fa-2x"></i></a>
    </div>	
</div>
<legend><?php echo $text_license; ?></legend>
<div class="form-group">
	<label class="col-sm-2 control-label" for="button-activate"><span data-toggle="tooltip" title="<?php echo $help_license; ?>"><?php echo $entry_license; ?></span></label>
	<div class="col-sm-10">
		<div class="input-group">
			<input type="text" name="<?php echo $extension; ?>_license" value="<?php echo $license; ?>" placeholder="<?php echo $entry_license; ?>" id="input-license" class="form-control"/>
			<span class="input-group-btn">
				<a onclick="purchase('activate')" id="button-activate" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="<?php echo $help_activate; ?>"><i class="fa fa-key"></i></a>
			</span>
		</div>
	</div>
</div>
<?php } else { ?>
<input type="hidden" name="<?php echo $extension; ?>_license" value="<?php echo $license; ?>" id="input-license" class="form-control" />
<?php } ?>
<legend><?php echo $text_support; ?></legend>
<address>
    <?php echo $text_about_support; ?>
</address>
<script type="text/javascript"><!--
function purchase(action) {
	switch(action) {
		case 'send':
			sUrl = 'email=' + encodeURIComponent($('#input-email').val()) + '&domain=' + encodeURIComponent($('#input-domain').val()) +'&market=' + encodeURIComponent($('#input-market').val()) +'&check=' + encodeURIComponent($('#input-check').val());        		
        break;
        case 'activate':
        	sUrl = 'license=' + $('#input-license').val();
        break;
    }
    
    $.ajax( {
    	url: 'index.php?route=tool/ocmax/purchase&action=' + action + '&extension=<?php echo $extension; ?>&token=<?php echo $token; ?>&' + sUrl,
    	dataType: 'json',
    	success: function (json) {
    		$('.alert').remove();
    		
    		if (json['error']) {
    			$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
    		}
    		
    		if (json['success']) {
    			$('.container-fluid:eq(1)').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
    		}
    		
    		$('html, body').animate({ scrollTop: 0 }, 'slow');

			if (json['redirect']) {
				setTimeout(function() { location.reload() }, 1000);
			}
    	},
    	error: function (jqXHR, textStatus, errorThrown) {
    		$('.alert').remove();
    		
    		$('.container-fluid:eq(1)').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_unexpected; ?><button type="button" class="close" data-dismiss="alert">&times;</button></div>');
    		
      	}
    } );
}
//--></script>