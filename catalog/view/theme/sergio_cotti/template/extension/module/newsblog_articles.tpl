<?php if ($articles) { ?>
    <!-- Box News -->
    <div id="news-box">
        <div class="container-fluid">
            <? if ($heading_title) { ?>
                <h2 class="text-center title-slider">Новости</h2>
            <? } ?>
            <div class="row">
                <?php foreach ($articles as $article) { ?>
                    <div class="col-lg-4">
                        <div class="card">
                            <a href="<?php echo $article['href']; ?>" class="figure-box">
                                <img class="card-img-top" src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>">
                            </a>
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $article['name']; ?></h5>
                                <p class="card-text"><?php echo $article['preview']; ?></p>
                            </div>
                            <div class="card-body">
                                <a href="<?php echo $article['href']; ?>" class="card-link"><?php echo $text_more; ?></a>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
    <!-- Box News end-->
<?php } ?>