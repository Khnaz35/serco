<?php if ($articles) { ?>
    <div class="article-list-module">
        <? if ($heading_title) { ?>
            <div class="page-sub_title">
                <a href="<?php echo $link_to_category; ?>"><?php echo $heading_title; ?></a>
            </div>
        <? } ?>
        <div class="container-modules">
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