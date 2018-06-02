    <footer>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                    <div class="footer-logo">
                        <?php $footer_logo_src = '/catalog/view/theme/cybershark/image/cotti/logo_footer.png'; ?>
                        <?php if ($home == $og_url) { ?>
                            <img src="<?php echo $footer_logo_src; ?>" />
                            
                            <div class="footer-logo-title">
                                <?php echo $text_logo; ?>
                            </div>
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>"><img src="<?php echo $footer_logo_src; ?>" /></a>
                            
                            <div class="footer-logo-title">
                                <a href="<?php echo $home; ?>"><?php echo $text_logo; ?></a>
                            </div>
                        <?php } ?>
                    </div>
                    <div class="footer-callback">
                        <a id="footer-callback-btn" class="b24-web-form-popup-btn-10" href="#callback"><?php echo $text_contact; ?></a>
                    </div>
                </div>
                
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <div class="row">
                        <?php if ($informations) { ?>
                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                <ul class="list-unstyled">
                                    <?php foreach ($informations as $information) { ?>
                                        <li>
                                            <a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            </div>
                        <?php } ?>
                        
                        <?php if ($categories) { ?>
                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                <ul class="list-unstyled">
                                    <?php foreach ($categories as $category) { ?>
                                        <li>
                                            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            </div>
                        <?php } ?>
                        
                        <?php if ($informations2) { ?>
                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                <ul class="list-unstyled">
                                    <?php foreach ($informations2 as $information2) { ?>
                                        <li>
                                            <a href="<?php echo $information2['href']; ?>"><?php echo $information2['title']; ?></a>
                                        </li>
                                    <?php } ?>
                                </ul>
                            </div>
                        <?php } ?>
                    </div>
                </div>
                
                <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
                            <?php if ($column_footer) { ?>
                                <?php echo $column_footer; ?>
                            <?php } ?>
                        </div>
                        
                        <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
                            <div class="footer-soc">
                                <div class="footer-soc-title">
                                    <?php echo $text_social; ?>
                                </div>
                                <ul>
                                    <li>
                                        <a href="https://www.facebook.com/Sergio.Kharkov.Cotti?ref=bookmarks" target="_blank" rel="nofollow"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                    </li>
                                    <li>
                                        <a href="#instagram" target="_blank" rel="nofollow"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                                    </li>
                                    <li>
                                        <a href="#twitter" target="_blank" rel="nofollow"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                                    </li>
                                    <li>
                                        <a href="https://vk.com/club65278479" target="_blank" rel="nofollow"><i class="fa fa-vk" aria-hidden="true"></i></a>
                                    </li>
                                    <li>
                                        <a href="https://ok.ru/group/52299969134813" target="_blank" rel="nofollow"><i class="fa fa-odnoklassniki" aria-hidden="true"></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        
            <div class="footer-line">
            </div>
            
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="footer-copyright">
                        <?php echo $powered; ?>
                    </div>
                </div>
                <?php /*<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="footer-dev">
                        <?php echo $text_dev; ?>
                    </div>
                </div>*/ ?>
            </div>
        </div>
    </footer>

        <?php if (isset($smca_status) || isset($smac_status)) { ?>
          <!-- start: OCdevWizard Setting -->
          <script type="text/javascript">     
            var ocdev_modules = [];
                  
            <?php if (isset($smca_status) && $smca_status == 1) { ?>
              ocdev_modules.push({
                src:  'index.php?route=ocdevwizard/smart_cart',
                type:'ajax'
              });
            <?php } ?>
            <?php if (isset($smac_status) && $smac_status == 1 && $smart_abandoned_cart == 1) { ?>
              ocdev_modules.push({
                src:  'index.php?route=ocdevwizard/smart_abandoned_cart',
                type:'ajax'
              });
            <?php } ?>
          </script>
          <!-- end: OCdevWizard Setting -->
        <?php } ?>
      
<script data-skip-moving="true">
        (function(w,d,u){
                var s=d.createElement('script');s.async=1;s.src=u+'?'+(Date.now()/60000|0);
                var h=d.getElementsByTagName('script')[0];h.parentNode.insertBefore(s,h);
        })(window,document,'https://cdn.bitrix24.ua/b5704879/crm/site_button/loader_2_7qczvz.js');
</script>
<script id="bx24_form_link" data-skip-moving="true">
        (function(w,d,u,b){w['Bitrix24FormObject']=b;w[b] = w[b] || function(){arguments[0].ref=u;
                (w[b].forms=w[b].forms||[]).push(arguments[0])};
                if(w[b]['forms']) return;
                var s=d.createElement('script');s.async=1;s.src=u+'?'+(1*new Date());
                var h=d.getElementsByTagName('script')[0];h.parentNode.insertBefore(s,h);
        })(window,document,'https://sergiocotti.bitrix24.ua/bitrix/js/crm/form_loader.js','b24form');

        b24form({"id":"10","lang":"ru","sec":"vzo26j","type":"link","click":""});
</script>
<!-- BEGIN TURBOPARSER CODE -->
<script type='text/javascript'>(function(a,b,c,d){var s = document.createElement(a); s.type = b; s.async = true; s.src = c; var ss = document.getElementsByTagName(d)[0]; ss.parentNode.insertBefore(s, ss);})('script', 'text/javascript', 'https://turboparser.ru/parser/widget/loader?hash=15c213e81d8dc4dac2482cdcbe490d01&ts='+Date.now(), 'script');</script>
<!-- END TURBOPARSER CODE -->

<!--start-->
<a href="#top" class="scrollToTop"></a>         
             
<script type="text/javascript">          
    $(document).ready(function(){
    	
    	//Check to see if the window is top if not then display button
    	$(window).scroll(function(){
    		if ($(this).scrollTop() > 100) {
    			$('.scrollToTop').fadeIn();
    		} else {
    			$('.scrollToTop').fadeOut();
    		}
    	});
    	
    	//Click event to scroll to top
    	$('.scrollToTop').click(function(e){
    		$('html, body').animate({scrollTop : 0},800);
    		e.preventDefault();
    	});
    	
    });        
</script>            
             
<style type="text/css">           
    .scrollToTop{
        cursor: pointer; 
        background-image: url("/catalog/view/theme/cybershark/image/scroll_to_top.png");
        background-repeat: no-repeat;
        background-size: 26px 39px;
        background-position: center center;
        width: 26px;
        height: 39px;
        position: fixed;
        bottom: 50px;
        right: 20px;
        z-index: 99;
    }
    .scrollToTop:hover{
    	opacity: 0.9;
    }          
</style>
   <!--end-->          
</body>
</html>