<?php echo $header; ?>
<div class="container canvas">
  
  <?php if (!empty($error_warning)) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<div class="main-title">
				<h1><?php echo $heading_title; ?></h1>
                <p>Номер Вашего заказа № <?=$order_id?>. С Вами свяжется менеджер, ответственный за Ваш заказ.</p>
                
            </div>
            <div class="page-cart">
                <h2>Детали заказа № <?=$order_id?></h2>
                <div class="col-sm-6">
                <div class="form form-detail">
                    <?php if($order['firstname']!=''){?>
                    <div class="form-ctrl"><span>Имя: </span><span><?=$order['firstname'];?></span></div>
                    <?php } ?>
                    <?php if($order['telephone']!=''){?>
                    <div class="form-ctrl"><span>Телефон: </span><span><?=$order['telephone'];?></span></div>
                    <?php } ?>
                    <?php if($order['email']!=''){?>
                    <div class="form-ctrl"><span>Email: </span><span><?=$order['email'];?></span></div>
                    <?php } ?>
                    <?php if($order['shipping_method']!=''){?>
                    <div class="form-ctrl"><span><?=$text_shipping_method?> </span><span><?=$order['shipping_method'];?></span></div>
                    <?php } ?>
                    <?php if($order['comment']!=''){?>
                    <div class="form-ctrl"><span>Комментарий к заказу: </span><span><?=$order['comment'];?></span></div>
                    <?php } ?>
                    
                </div>
                </div>
                    <div class="col-sm-6">
                <div class="my-order my-order-detail">
                    <div class="title"><h4>Ваш заказ</h4></div>
                    <ul>
                       <?php foreach ($products as $product) { ?>
                        <li>
                            <div class="row">
                                <div class="col-sm-3">
                            <div class="thumbnail"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"></div>
                                </div>
                                <div class="col-sm-9">
                            <div class="info">
                                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                <div class="code"><span>Код: <?php echo $product['model']; ?></span></div>
                                <div class="count-price">
                                    <div class="row">
                                        <div class="count-box"><span>Количество</span><span><?php echo $product['quantity']; ?> шт.</span></</div>
                                        <div class="price"><span><?php echo $product['price']; ?> </span></div>
                                    </div>
                                </div>
                            </div>
                                </div>
                            </div>
                        </li>
                    <?php } ?>
                    </ul>
                    <div class="pay clearfix">
                        <div class="col-sm-6">
                        <span>К оплате</span>
                        </div>
                        <div class="col-sm-6">
                                <div class="total"><span><?php echo $total; ?></span> </div>
                        </div>
                    </div>
                </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="btn-holder">
                            <a href="/" class="btn btn-red">Продолжить покупки</a>
                        </div>
                    </div>
            </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
