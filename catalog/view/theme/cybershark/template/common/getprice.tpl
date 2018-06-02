<div id="popup-getprice">
    <div class="popup-heading">
        <?php echo $title_getprice; ?>
    </div>
	<div class="popup-center">
		<form id="getprice_data" enctype="multipart/form-data" method="post">
            <div class="anytext-getprice marb col-xs-12 text-center">
                <?php echo $text_before_button_send; ?>
            </div>
            
            <div class="col-sm-12 form-group sections_block_rquaired">
                <div class="input-group margin-bottom-sm">                         
                    <input id="contact-email" class="form-control contact-email" id="contact-email" type="text" placeholder="<?php echo $text_email_buyer; ?>" value=""  name="email_buyer" />
                    <span class="input-group-addon"><i class="icon-append-1 fa fa-envelope fa-fw"></i></span>
                </div>
            </div>
            
            <input id="contact-product_id" class="form-control contact-product_id hidden" id="contact-product_id" type="text" value="<?php echo $product_id; ?>"  name="product_id" />
		</form>
	</div>
	<div class="popup-footer">		
        <div id="getprice_btn">
			<button type="button" onclick="getprice_confirm();" class="btn btn-getprice-one"><?php echo $button_send; ?></button>
		</div>
    </div>
</div>