<div id="popup-getcatalog">
    <div class="popup-heading">
        <?php echo $title_getcatalog; ?>
    </div>
	<div class="popup-center">
		<form id="getcatalog_data" enctype="multipart/form-data" method="post">
            <div class="anytext-getcatalog marb col-xs-12 text-center">
                <?php echo $text_before_button_send; ?>
            </div>
            
            <div class="col-sm-12 form-group sections_block_rquaired">
                <div class="input-group margin-bottom-sm">                         
                    <input id="contact-email" class="form-control contact-email" id="contact-email" type="text" placeholder="<?php echo $text_email_buyer; ?>" value=""  name="email_buyer" />
                    <span class="input-group-addon"><i class="icon-append-1 fa fa-envelope fa-fw"></i></span>
                </div>
            </div>
		</form>
	</div>
	<div class="popup-footer">		
        <div id="getcatalog_btn">
			<button type="button" onclick="getcatalog_confirm();" class="btn btn-getcatalog-one"><?php echo $button_send; ?></button>
		</div>
    </div>
</div>