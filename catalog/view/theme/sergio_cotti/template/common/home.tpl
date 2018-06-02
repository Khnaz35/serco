<?php echo $header; ?>

    <!-- Content -->
    <div id="content" class="content">

        <?php if ($content_top) { ?>
                <?php echo $content_top; ?>
        <?php } ?>

        <?php if ($column_baner1) { ?>
                <?php echo $column_baner1; ?>
        <?php } ?>

        <?php if ($column_baner2) { ?>
                <?php echo $column_baner2; ?>
        <?php } ?>

        <?php if ($column_baner3) { ?>
                <?php echo $column_baner3; ?>
        <?php } ?>



        <?php if ($column_center) { ?>
                <?php echo $column_center; ?>
        <?php } ?>
    </div>
    <!-- Content end-->


    <?php if ($column_left) { ?>
            <?php echo $column_left; ?>
    <?php } ?>

    <?php if ($column_right) { ?>
            <?php echo $column_right; ?>
    <?php } ?>

<?php if ($content_bottom) { ?>
    <?php echo $content_bottom; ?>
<?php } ?>

<?php echo $footer; ?>