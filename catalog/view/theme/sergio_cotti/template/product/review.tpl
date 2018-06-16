<?php if ($reviews) { ?>
    <?php foreach ($reviews as $review) { ?>
        <div class="comment-text clearfix">
            <p class="meta"> <strong><?php echo $review['author']; ?></strong>
                <time><?php echo $review['date_added']; ?></time>
            </p>
            <div class="star-rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($review['rating'] < $i) { ?>
                        <span class="fa fa-star"></span>
                    <?php } else { ?>
                        <span class="fa fa-star checked"></span>
                    <?php } ?>
                <?php } ?>
            </div>
            <div class="description">
                <p><?php echo $review['text']; ?></p>
            </div>
        </div>
    <?php } ?>

    <div class="box-pagination">
        <nav>
            <?php echo $pagination; ?>
        </nav>
    </div>
<?php } else { ?>
    <?php echo $text_no_reviews; ?>
<?php } ?>