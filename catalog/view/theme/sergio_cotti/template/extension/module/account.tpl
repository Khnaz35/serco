<div class="list-group">
    <?php if (!$logged) { ?>
        <a href="<?php echo $login; ?>" class="list-group-item<?php if ($login_selected) { ?> selected<?php } ?>"><?php echo $text_login; ?></a> 
        <a href="<?php echo $register; ?>" class="list-group-item<?php if ($register_selected) { ?> selected<?php } ?>"><?php echo $text_register; ?></a> 
        <a href="<?php echo $forgotten; ?>" class="list-group-item<?php if ($forgotten_selected) { ?> selected<?php } ?>"><?php echo $text_forgotten; ?></a>
    <?php } else { ?>
        <a href="<?php echo $account; ?>" class="list-group-item<?php if ($account_selected) { ?> selected<?php } ?>"><?php echo $text_account; ?></a>
        <a href="<?php echo $edit; ?>" class="list-group-item<?php if ($edit_selected) { ?> selected<?php } ?>"><?php echo $text_edit; ?></a> 
        <a href="<?php echo $password; ?>" class="list-group-item<?php if ($password_selected) { ?> selected<?php } ?>"><?php echo $text_password; ?></a>
    
        <a href="<?php echo $address; ?>" class="list-group-item<?php if ($address_selected) { ?> selected<?php } ?>"><?php echo $text_address; ?></a> 
        <a href="<?php echo $wishlist; ?>" class="list-group-item<?php if ($wishlist_selected) { ?> selected<?php } ?>"><?php echo $text_wishlist; ?></a> 
        <a href="<?php echo $order; ?>" class="list-group-item<?php if ($order_selected) { ?> selected<?php } ?>"><?php echo $text_order; ?></a> 
        <a href="<?php echo $reward; ?>" class="list-group-item<?php if ($reward_selected) { ?> selected<?php } ?>"><?php echo $text_reward; ?></a> 
        <a href="<?php echo $return; ?>" class="list-group-item<?php if ($return_selected) { ?> selected<?php } ?>"><?php echo $text_return; ?></a> 
        <a href="<?php echo $newsletter; ?>" class="list-group-item<?php if ($newsletter_selected) { ?> selected<?php } ?>"><?php echo $text_newsletter; ?></a>
        <a href="<?php echo $logout; ?>" class="list-group-item<?php if ($logout_selected) { ?> selected<?php } ?>"><?php echo $text_logout; ?></a>
    <?php } ?>
    
    <?php /*<a href="<?php echo $download; ?>" class="list-group-item<?php if ($download_selected) { ?> selected<?php } ?>"><?php echo $text_download; ?></a> */ ?>
    <?php /*<a href="<?php echo $recurring; ?>" class="list-group-item<?php if ($recurring_selected) { ?> selected<?php } ?>"><?php echo $text_recurring; ?></a> */ ?>
    <?php /*<a href="<?php echo $transaction; ?>" class="list-group-item<?php if ($transaction_selected) { ?> selected<?php } ?>"><?php echo $text_transaction; ?></a> */ ?>
</div>