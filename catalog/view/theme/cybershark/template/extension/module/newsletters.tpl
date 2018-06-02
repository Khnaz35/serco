<div class="box-newsletter">
    <div class="box-newsletter-title">
        <? echo $heading_title; ?>    
    </div>
    <form action="" method="post" class="form-inline" class="newsletter">
        <input type="email" name="txtemail" id="txtemail" value="" placeholder="<? echo $entry_submit; ?>" class="form-control" /> 
        <button type="submit" class="newsletter" onclick="return subscribe();"><? echo $button_submit; ?></button>
        <div class="clearfix">
        </div>
    </form>
</div>