<?php if ($reviews) { ?>
    <?php foreach ($reviews as $review) { ?>
        <div class="review-item">      
            <div class="row">      
                <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
                    <div class="review-author">
                        <?php echo $review['author']; ?>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                    <div class="review-rating">
                        <div class="rating">
                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                                <?php if ($review['rating'] < $i) { ?>
                                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                <?php } else { ?>
                                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                    <div class="review-date_added">
                        <?php echo $review['date_added']; ?>
                    </div>
                </div>
            </div>
            <div class="row">  
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="review-text">
                        <?php echo $review['text']; ?>
                    </div>
                </div>
            </div>  
        </div>    
    <?php } ?>
    
    <div class="row-pagination row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="pagination-container">
                <?php echo $pagination; ?>
            </div>
        </div>
    </div>
<?php } else { ?>
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="text_empty-container">
                <?php echo $text_no_reviews; ?>
            </div>
        </div>
    </div>
<?php } ?>