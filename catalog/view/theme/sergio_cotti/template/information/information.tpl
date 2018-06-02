<?php echo $header; ?>

<div class="container">

    <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
    
    <div class="row">
        
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-6 col-lg-6 pull-center'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-9 col-lg-9 pull-right'; ?>
        <?php } else { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-12 col-lg-12'; ?>
        <?php } ?>
    
        <div id="content" class="<?php echo $class; ?>">
        
            <?php if ($content_top) { ?>
                <div id="content-top">
                    <?php echo $content_top; ?>
                </div>
            <?php } ?>
            
            <h1 class="page_title"><?php echo $heading_title; ?></h1>
            
            <?php if ($shoplists) { ?>
                <div id="content-shoplist">
                    <?php $i = 1; ?>
                    <?php foreach ($shoplists as $shop) { ?>
                        <div class="shoplist-item clearfix">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                    <div class="shoplist-title">
                                        <?php echo($i . ') ' . $shop['title']); ?>
                                    </div>
                                    <?php if ($shop['address']) { ?>
                                        <div class="shoplist-address">
                                            <div class="shoplist-label">
                                                <?php echo $text_shop_address; ?>
                                            </div>
                                            <?php echo $shop['address']; ?>
                                        </div>
                                    <?php } ?>
                                    <?php if ($shop['phone']) { ?>
                                        <div class="shoplist-phone">
                                            <div class="shoplist-label">
                                                <?php echo $text_shop_phone; ?>
                                            </div>
                                            <?php echo $shop['phone']; ?>
                                        </div>
                                    <?php } ?>
                                    <?php if ($shop['email']) { ?>
                                        <div class="shoplist-email">
                                            <div class="shoplist-label">
                                                <?php echo $text_shop_email; ?>
                                            </div>
                                            <?php echo $shop['email']; ?>
                                        </div>
                                    <?php } ?>
                                    <?php if ($shop['workingtime']) { ?>
                                        <div class="shoplist-workingtime">
                                            <div class="shoplist-label">
                                                <?php echo $text_shop_workingtime; ?>
                                            </div>
                                            <?php echo $shop['workingtime']; ?>
                                        </div>
                                    <?php } ?>
                                    <?php if ($shop['description']) { ?>
                                        <div class="shoplist-description">
                                            <?php echo $shop['description']; ?>
                                        </div>
                                    <?php } ?>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                    <?php if ($shop['googlemap']) { ?>
                                        <div class="shoplist-googlemap">
                                            <?php echo $shop['googlemap']; ?>
                                        </div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <?php $i++; ?>
                    <?php } ?>
                </div>
            <?php } ?>
            
            
            <?php if ($googlemap) { ?>
                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                        <div class="page-content clearfix">
                            <?php echo $description; ?>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                        <div class="page-googlemap">
                            <?php echo $googlemap; ?>
                        </div>
                    </div>
                </div>
            <?php } else { ?>
                <div class="page-content clearfix">
                    <?php echo $description; ?>
                </div>
            <?php } ?>
            
            <?php if ($contact_form_on == 1) { ?>
                <div class="page-contact-form-container">
                    <div class="page-contact-form">
                        <div class="page-contact-form-heading">
                            <?php echo $title_sendform; ?>
                        </div>
                    	<div class="page-contact-form-center">
                    		<form id="sendform_data" enctype="multipart/form-data" method="post">
                                <div class="anytext-sendform marb col-xs-12 text-center">
                                    <?php echo $text_before_button_send; ?>
                                </div>
                                
                                <div class="col-sm-12 form-group sections_block_rquaired">
                        			<div class="input-group margin-bottom-sm">			
                        				 <input id="sendform-name" class="form-control contact-name" type="text" placeholder="<?php echo $text_name_buyer; ?>" value="" name="name_buyer">		
                        				<span class="input-group-addon"><i class="icon-append-1 fa fa-user fa-fw"></i></span>
                        			</div>
                                </div>
                                
                                <div class="col-sm-12 form-group sections_block_rquaired">
                        			<div class="input-group margin-bottom-sm">			
                        				 <input id="sendform-phone" class="form-control contact-phone" type="text" placeholder="<?php echo $text_phone_buyer; ?>" value="" name="phone_buyer">		
                        				<span class="input-group-addon"><i class="icon-append-1 fa fa-phone-square fa-fw"></i></span>
                        			</div>
                                </div>
                                
                                <div class="col-sm-12 form-group sections_block">
                                    <div class="input-group margin-bottom-sm">                         
                                        <input id="sendform-email" class="form-control contact-email-buyer" type="text" placeholder="<?php echo $text_email_buyer; ?>" value=""  name="email_buyer" />
                                        <span class="input-group-addon"><i class="icon-append-1 fa fa-envelope fa-fw"></i></span>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 form-group sections_block">
                            		<div class="input-group margin-bottom-sm">                          
                                        <textarea id="sendform-comment" class="form-control contact-comment-buyer" placeholder="<?php echo $text_comment_buyer;?>" name="comment_buyer"></textarea>
                            			<span class="input-group-addon"><i class="icon-append-1 fa fa-comment fa-fw"></i></span>	
                            		</div>
                                </div>
                                
                                <input id="sendform-page-name" class="form-control contact-page-name hidden" type="text" value="<?php echo $heading_title; ?>"  name="page_name" />
                                <input id="sendform-bot-catcher" class="form-control contact-bot-catcher hidden" type="text" value=""  name="bot_catcher" />
                    		</form>
                    	</div>
                    	<div class="page-contact-form-footer">		
                            <div id="sendform_btn">
                    			<button type="button" onclick="sendform_confirm();" class="btn btn-primary btn-sendform"><?php echo $button_send; ?></button>
                    		</div>
                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                	$(document).ready(function() {
                		$("#sendform-phone").mask("+38 (999) 999-99-99");
                	});
                </script>
            <?php } ?>
              
            <?php if ($content_bottom) { ?>
                <div id="content-bottom">
                    <?php echo $content_bottom; ?>
                </div>
            <?php } ?>
        </div>
        
        <?php if ($column_left) { ?>
            <div id="column-left" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_left; ?>
            </div>
        <?php } ?>
        
        <?php if ($column_right) { ?>
            <div id="column-right" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_right; ?>
            </div>
        <?php } ?>
        
    </div>
 <?php echo $galery_diplom; ?>
</div>

<?php echo $footer; ?>