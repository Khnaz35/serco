<?php echo $header; ?>

<div class="container">

    <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
                <?php $current_page_link = $breadcrumb['href']; ?>
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
            
            <div class="page-content">
                <div class="row">
                    <?php if ($thumb) { ?>
                        <div class="col-xs-12 col-sm-6 col-md-5 col-lg-4">
                            <div class="article-thumbs article-thumb">
                                <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
                            </div>
                        </div>
                    <div class="col-xs-12 col-sm-6 col-md-7 col-lg-8">
    	            <?php } else { ?>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    	            <?php } ?>
                        <?php //echo $preview;?>
                        <?php echo $description; ?>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="article-share">
                            <div class="article-share-title">
                                <?php echo $text_share; ?>
                            </div>
                            <div class="share42init" data-url="<?php echo $current_page_link; ?>" data-title="<?php echo $heading_title; ?>" data-image="<?php echo $share_image; ?>" data-description="<?php echo $description; ?>"></div>
                        </div>
                    </div>
                </div> 
                
                <?php if ($images) { ?>
                    <div class="row">
                        <div class="article-thumbs article-thumbs-min">
                            <?php foreach ($images as $image) { ?>
                                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                                    <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>">
                                        <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                                    </a>
                                </div>
                            <?php } ?>
                            
                            <div class="clearfix">
                            </div>
                        </div>
                        
                        <div class="clearfix">
                        </div>
                    </div>
                <?php } ?>
            </div>
            

            <?php if ($articles) { ?>
                <div class="article-list">
                    <div class="page-sub_title">
                        <?php echo $text_related; ?>
                    </div>
                    <div class="container-modules related_articles">
                        <?php foreach ($articles as $article) { ?>	
                                <div class="article-list-item">
                                    <div class="article-list-date">
                                        <?php echo $article['date']; ?>
                                    </div>
                                    <div class="article-list-title">
                                        <a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a>
                                    </div>
                                    <div class="article-list-text">
                                        <?php echo $article['preview']; ?>
                                    </div>
                                </div>
                        <?php } ?>
                    </div>
                </div>
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
    
</div>


<script type="text/javascript"><!--
$(document).ready(function() {
	$('.article-thumbs').magnificPopup({
		type:'image',
		delegate: 'a',
        tClose: 'Закрыть',
        tLoading: 'Загрузка...',
        gallery: {
			enabled: true,
            tPrev: 'Назад',
            tNext: 'Вперёд',
            tCounter: 'Изображение %curr% из %total%'
        },
        image: {
            tError: '<a href="%url%">Изображение</a> не может быть загружено.'
        },
        ajax: {
            tError: '<a href="%url%">Запрос</a> неудался.'
        }
    });
});
//--></script>
<?php echo $footer; ?>