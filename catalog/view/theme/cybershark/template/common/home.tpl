<?php echo $header; ?>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.10&appId=253735511473385";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="container">

    <div class="row">
    
        <div id="content" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        
            <?php if ($content_top) { ?>
                <div id="content-top">
                    <?php echo $content_top; ?>
                </div>
            <?php } ?>
            
            <div class="row">
                <?php if ($column_baner1) { ?>
                    <div id="column-banner-1" class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                        <?php echo $column_baner1; ?>
                    </div>
                <?php } ?>
                
                <?php if ($column_baner2) { ?>
                    <div id="column-banner-2" class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                        <?php echo $column_baner2; ?>
                    </div>
                <?php } ?>
                
                <?php if ($column_baner3) { ?>
                    <div id="column-banner-2" class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                        <?php echo $column_baner3; ?>
                    </div>
                <?php } ?>
            
            </div>
            
            <div id="home-benefits">

                <?php if ($config_benefit_block_show == 1) { ?>
                    <?php if ($benefit_icons) { ?>
                        <div class="benefits-title">
                            <?php echo($text_benefits); ?>
                        </div>
                        <div class="benefits-container">
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <div class="benefit-icons">
                                        <div class="benefit-icons-container">
                                            <div class="row">
                                                <?php foreach ($benefit_icons as $benefit_icon) { ?>
                                                    <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                                                        <div class="benefit-icon-container">
                                                            <?php if ($benefit_icon['image']) { ?>
                                                                <div class="benefit-icon-img">
                                                                    <div>
                                                                        <img src="<?php echo($benefit_icon['image']); ?>" class="img-responsive" />
                                                                    </div>
                                                                </div>
                                                            <?php } ?>
                                                            
                                                            <div class="benefit-icon-text">
                                                                <?php if ($benefit_icon['title']) { ?>
                                                                    <div class="benefit-icon-title">
                                                                        <?php echo($benefit_icon['title']); ?>
                                                                    </div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                    </div>
                                                <?php } ?>
                                                <div class="clearfix">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                <?php } ?>
             
            </div>
            
            <?php if ($column_center) { ?>
                <div id="column-center">
                    <?php echo $column_center; ?>
                </div>
            <?php } ?>
            
        </div>
          <?php echo $galery_diplom; ?>
            <?php if ($column_left) { ?>
                <div id="column-left" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <?php echo $column_left; ?>
                </div>
            <?php } ?>
            
            <?php //if ($column_right) { ?>
                <div id="column-right" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <?php //echo $column_right; ?>
                    <div class="column-right-inner">
                        <div class="html-module">
                            <div class="html-module-title">
                                Следите за нами
                            </div>
                            <div class="html-module-body">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                        Инстаграмм
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                        <div class="fb-page" data-href="https://www.facebook.com/Sergio.Kharkov.Cotti" data-height="290" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="https://www.facebook.com/Sergio.Kharkov.Cotti" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/Sergio.Kharkov.Cotti">Sergio-Cotti</a></blockquote></div>
                                    </div>
                                </div>    
                            </div>
                        </div>
                    </div>
                </div>
            <?php //} ?>
        
    </div>
    
</div>

<?php if ($content_bottom) { ?>
    <div id="home-page-bottom">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div id="home-page-seo-text">
                        <?php echo $content_bottom; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
<?php } ?>

<?php echo $footer; ?>