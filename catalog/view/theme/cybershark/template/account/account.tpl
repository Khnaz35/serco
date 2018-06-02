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
    
    <h1 class="page_title"><?php echo $text_my_account; ?></h1>
    
    <?php if ($success) { ?>
        <script type="text/javascript"><!--
            $(document).ready(function() {
                $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only"><?php echo $text_modal_close; ?></span></button><div class="modal-title"><?php echo $text_modal_success; ?></div></div><div class="modal-body"><div class="text-center"><div class="popup-name"><?php echo $success; ?></div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
                $('#modal-success').modal('show');
            }); 
        //--></script>
    <?php } ?>
    
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
            
            
            <div class="page-content">
            
                <ul class="list-unstyled">
                    <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
                    <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
                    <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
                    <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                    <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                    <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
                    <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                    <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                </ul>
                
                
                <?php /*<h2><?php echo $text_my_orders; ?></h2>
                <ul class="list-unstyled">
                    <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                    <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                    <li><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
                </ul>
                
                <h2><?php echo $text_my_newsletter; ?></h2>
                <ul class="list-unstyled">
                    <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                </ul>
                
                <?php if ($credit_cards) { ?>
                  <h2><?php echo $text_credit_card; ?></h2>
                  <ul class="list-unstyled">
                    <?php foreach ($credit_cards as $credit_card) { ?>
                    <li><a href="<?php echo $credit_card['href']; ?>"><?php echo $credit_card['name']; ?></a></li>
                    <?php } ?>
                  </ul>
                <?php }*/ ?>
    
            </div>
            
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
    
</div>

<?php echo $footer; ?>