    <!-- Footer -->
    <footer id="footer">
        <div class="container-fluid text-center">
            <? echo $newsletter; ?>
            <?php if ($informations) { ?>
                <div class="nav-footer">
                    <ul class="list-unstyled">
                        <?php foreach ($informations as $information) { ?>
                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                        <?php } ?>
                    </ul>
                </div>
            <?php } ?>
            <div class="nav-socialnetwork">
                <ul class="list-unstyled">
                    <li><a href="https://www.facebook.com/Sergio.Kharkov.Cotti?ref=bookmarks" target="_blank" rel="nofollow"><i class="fab fa-facebook-f"></i></a></li>
                    <li><a href="https://vk.com/club65278479" target="_blank" rel="nofollow"><i class="fab fa-vk"></i></a></li>
                    <li><a href="#instagram" target="_blank" rel="nofollow"><i class="fab fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fab fa-youtube"></i></a></li>
                    <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                    <li><a  href="https://ok.ru/group/52299969134813" target="_blank" rel="nofollow"><i class="fab fa-odnoklassniki"></i></a></li>
                </ul>
            </div>
            <span class="nav-locale-copyright">
                <span class="copyright"><? echo $powered; ?></span>
            </span>
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
      
    <!-- Footer end-->
</div>
<!-- Wrapper for mobile menu end-->

<script>
    $( ".header-search" ).click(function() {
        $('.search-fixed').addClass('opened');
    });
</script>
<script>
    $( ".search-close" ).click(function() {
        $('.search-fixed').removeClass('opened');
    });
</script>
<script>
    jQuery(document).ready(function($) {
        $('.submenu > li').matchHeight();
    });
</script>
</body>
</html>