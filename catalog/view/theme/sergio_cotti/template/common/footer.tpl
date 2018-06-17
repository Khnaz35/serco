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
    <!-- Footer end-->

    <!--  Mobile menu -->
    <nav id="menu" class="d-md-none">
        <ul>
            <li>
                <input type="text" class="mobile-menu-search" name="m_search" placeholder="Поиск">
                <a href="#" class="mobile-search-icon"><i class="fal fa-search"></i></a>
            </li>

            <?php foreach ($categories as $category) { ?>
                <li><a href="<?php echo $category['href']; ?>" <?php echo (($category['style'])? 'style="' . $category['style'] . '"' : '') ?>><?php echo $category['name']; ?></a>
                <?php if ($category['children']) { ?>
                    <ul>
                    <?php foreach ($category['children'] as $child) { ?>
                        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                        <?php if ($child['children']) { ?>
                            <ul>
                            <?php foreach ($child['children'] as $subchild) { ?>
                                <li><a href="<?php echo $subchild['href']; ?>"><?php echo $subchild['name']; ?></a></li>
                            <?php } ?>
                            </ul>
                        <?php } ?>
                        </li>
                    <?php } ?>
                    </ul>
                <?php } ?>
                </li>
            <?php } ?>
        </ul>
    </nav>
    <!--  Mobile menu -->
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