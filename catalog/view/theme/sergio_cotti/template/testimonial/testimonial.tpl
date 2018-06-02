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
            
            
            <div id="tab-review">
                <div id="review"></div>
            
                <form class="form-horizontal" id="form-review">
                    
                    <div class="review-title">
                        <?php echo $text_write; ?>
                    </div>
                            
                    <?php if ($review_guest) { ?>
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <div class="col-sm-12">
                                <label class="control-label"><?php echo $entry_rating; ?></label>
                                    <div class="review_rating_stars">
                                        <ul>
                                            <li>
                                                <a id="review_rating_star_1" class="" href="#1"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_2" class="" href="#2"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_3" class="" href="#3"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_4" class="" href="#4"></a>
                                            </li>
                                            <li>
                                                <a id="review_rating_star_5" class="" href="#5"></a>
                                            </li>
                                        </ul>
                                    </div>
                                <input name="rating" value="0" type="hidden">
                            </div>
                        </div>
                        
                        <div class="buttons clearfix">
                            <div class="pull-left">
                                <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                            </div>
                        </div>
                    <?php } else { ?>
                        <?php echo $text_login; ?>
                    <?php } ?>
                </form>
                
                <?php if ($content_bottom) { ?>
                    <div id="content-bottom">
                        <?php echo $content_bottom; ?>
                    </div>
                <?php } ?>
            </div>
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
    <script type="text/javascript"><!--
        $('#review').delegate('.pagination a', 'click', function (e) {
            e.preventDefault();
            $('#review').load(this.href);
        });

    //--></script>
    <script type="text/javascript"><!--
        $('#review').load('<?php echo html_entity_decode($review); ?>');

        $('#button-review').on('click', function () {
            $.ajax({
                url: '<?php echo html_entity_decode($write); ?>',
                type: 'post',
                dataType: 'json',
                data:  $("#form-review").serialize(),
                beforeSend: function () {
                    if ($("textarea").is("#g-recaptcha-response")) {
                        grecaptcha.reset();
                    }
                    $('#button-review').button('loading');
                },
                complete: function () {
                    $('#button-review').button('reset');
                },
                success: function (json) {
                    
                    $('.alert-success, .alert-danger').remove();
                    if (json['error']) {
                        
             $('#content').parent().before('<div id="modal-warning" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Внимание!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['error'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
             $('#modal-warning').modal('show');
             
                    }
                    if (json['success']) {
                        
             $('#content').parent().before('<div id="modal-success" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Успех!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['success'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="clearfix"></div></div></div>	</div></div></div>');
             $('#modal-success').modal('show');
             

                        $('input[name=\'name\']').val('');
                        $('textarea[name=\'text\']').val('');
                        $('input[name=\'rating\']:checked').prop('checked', false);
                    }
                }
            });
        });
        //--></script>

<script type="text/javascript"><!--
    $('#review_rating_star_1').on('click', function(e) {
        $('input[name="rating"]').val('1');
        $('.review_rating_stars').addClass('selected_star_1').removeClass('selected_star_2').removeClass('selected_star_3').removeClass('selected_star_4').removeClass('selected_star_5');
        return false;
	});
    $('#review_rating_star_2').on('click', function(e) {
        $('input[name="rating"]').val('2');
        $('.review_rating_stars').addClass('selected_star_2').removeClass('selected_star_1').removeClass('selected_star_3').removeClass('selected_star_4').removeClass('selected_star_5');
        return false;
	});
    $('#review_rating_star_3').on('click', function(e) {
        $('input[name="rating"]').val('3');
        $('.review_rating_stars').addClass('selected_star_3').removeClass('selected_star_1').removeClass('selected_star_2').removeClass('selected_star_4').removeClass('selected_star_5');
        return false;
	});
    $('#review_rating_star_4').on('click', function(e) {
        $('input[name="rating"]').val('4');
        $('.review_rating_stars').addClass('selected_star_4').removeClass('selected_star_1').removeClass('selected_star_2').removeClass('selected_star_3').removeClass('selected_star_5');
        return false;
	});
    $('#review_rating_star_5').on('click', function(e) {
        $('input[name="rating"]').val('5');
        $('.review_rating_stars').addClass('selected_star_5').removeClass('selected_star_1').removeClass('selected_star_2').removeClass('selected_star_3').removeClass('selected_star_4');
        return false;
	});
    
    
    
    $('#review_rating_star_1').hover(function(e) {
        $('.review_rating_stars').addClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	}, 
    function(e) {
        $('.review_rating_stars').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	});
    
    $('#review_rating_star_2').hover(function(e) {
        $('.review_rating_stars').addClass('hover_star_2').removeClass('hover_star_1').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	}, 
    function(e) {
        $('.review_rating_stars').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	});
    
    $('#review_rating_star_3').hover(function(e) {
        $('.review_rating_stars').addClass('hover_star_3').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	}, 
    function(e) {
        $('.review_rating_stars').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	});
    
    $('#review_rating_star_4').hover(function(e) {
        $('.review_rating_stars').addClass('hover_star_4').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_5');
        return false;
	}, 
    function(e) {
        $('.review_rating_stars').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	});
    
    $('#review_rating_star_5').hover(function(e) {
        $('.review_rating_stars').addClass('hover_star_5').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4');
        return false;
	}, 
    function(e) {
        $('.review_rating_stars').removeClass('hover_star_1').removeClass('hover_star_2').removeClass('hover_star_3').removeClass('hover_star_4').removeClass('hover_star_5');
        return false;
	});
    
//--></script>
             
<?php echo $footer; ?>