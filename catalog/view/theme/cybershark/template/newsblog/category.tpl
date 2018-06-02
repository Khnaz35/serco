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
            
            <?php if ($categories) { ?>  
                <div class="sub-categories-list">
                    <div class="page-sub_title">
                        <?php echo $text_refine; ?>
                    </div>
                    <div class="sub-categories-body">
                        <div class="row">
                            <?php foreach ($categories as $category) { ?>
                                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                                    <div class="sub-category-item">
                                        <a href="<?php echo $category['href']; ?>">
                                            <div class="sub-category-image">
                                                <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" />
                                            </div>
                                            <div class="sub-category-title">
                                                <?php echo $category['name']; ?>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            <?php } ?>
                            <div class="clearfix">
                            </div>
                        </div>
                    </div>
                </div>
            <?php } ?>
            
            
            <?php if ($articles) { ?>
                <div class="article-list">
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
                    
                    <div class="pagination-results">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-left">
                                <?php echo $pagination; ?>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-right">
                                <div class="results">
                                    <?php echo $results; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            <?php } ?>
        
        
            <?php if (!$categories && !$articles) { ?>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="text_empty-container">
                            <?php echo $text_empty; ?>
                        </div>
                    </div>
                </div>
            <?php } ?>
      
            <?php if (($thumb || $description) && (!isset($_GET['page']))) { ?>
                <div class="category-description">
                    <div class="row">
                        <?php if (($description) && (!isset($_GET['page']))){ ?>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <?php if ($thumb) { ?>
                                    <div class="float-left"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
                                <?php } ?>
                                <?php echo $description; ?>
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

<?php echo $footer; ?>