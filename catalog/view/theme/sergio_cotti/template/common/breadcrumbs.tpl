<?php
$li_bc = count($breadcrumbs) - 1;
if($li_bc >= 0){
?>
<!-- Breadcrumbs -->
<div class="container-fluid">
    <div class="box-breadcrumb">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <?php for($i = 0; $i <= $li_bc; $i++) { ?>
                    <?php if($i !== $li_bc){?>
                        <li class="breadcrumb-item"><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><?php echo $breadcrumbs[$i]['text'];?></a></li>
                    <?php } else {?>
                        <li class="breadcrumb-item active" aria-current="page"><?php echo $breadcrumbs[$i]['text'];?></li>
                    <?php } ?>
                <?php } ?>
            </ol>
        </nav>
    </div>
</div>
<!-- Breadcrumbs end-->
<?php }