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
    
    <h1 class="page_title"><?php echo $heading_title; ?></h1>
    
    <?php if ($success) { ?>
        <script type="text/javascript"><!--
            $(document).ready(function() {
                $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only"><?php echo $text_modal_close; ?></span></button><div class="modal-title"><?php echo $text_modal_success; ?></div></div><div class="modal-body"><div class="text-center"><div class="popup-name"><?php echo $success; ?></div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
                $('#modal-success').modal('show');
            }); 
        //--></script>
    <?php } ?>
    
    <?php if ($error_warning) { ?>
        <script type="text/javascript"><!--
            $(document).ready(function() {
                $('#content').parent().before('<div id="modal-warning" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only"><?php echo $text_modal_close; ?></span></button><div class="modal-title"><?php echo $text_modal_warning; ?></div></div><div class="modal-body"><div class="text-center"><div class="popup-name"><?php echo $error_warning; ?></div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div></div></div></div>');
                $('#modal-warning').modal('show');
            }); 
        //--></script>
    <?php } ?>
    
    <div class="row">
        
        <?php /*if ($column_left && $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-6 col-lg-6 pull-center'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-9 col-lg-9 pull-right'; ?>
        <?php } else {*/ ?>
            <?php $class = 'col-xs-12 col-sm-12 col-md-12 col-lg-12'; ?>
        <?php /*}*/ ?>
    
        <div id="content" class="<?php echo $class; ?>">
        
            <?php if ($content_top) { ?>
                <div id="content-top">
                    <?php echo $content_top; ?>
                </div>
            <?php } ?>
            
            
            <div class="page-content login-page-content clearfix">
            
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                    <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                    <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                    </div>
                    <div class="form-group">
                    <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                    <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                    </div>
                    <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary login-page-submit" />
                    <?php if ($redirect) { ?>
                        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                    <?php } ?>
                
                    <div class="login-page-links">
                        <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a>
                        <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
                    </div>
                </form>
              
            </div>
            
            <?php if ($content_bottom) { ?>
                <div id="content-bottom">
                    <?php echo $content_bottom; ?>
                </div>
            <?php } ?>
        </div>
        
        <?php /*if ($column_left) { ?>
            <div id="column-left" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_left; ?>
            </div>
        <?php } ?>
        
        <?php if ($column_right) { ?>
            <div id="column-right" class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                <?php echo $column_right; ?>
            </div>
        <?php }*/ ?>
        
    </div>
    
</div>

<?php echo $footer; ?>