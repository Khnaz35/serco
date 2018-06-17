<?php echo $header; ?>

<?php if ($content_top) { ?>
    <div id="content-top">
        <?php echo $content_top; ?>
    </div>
<?php } ?>

<?php if ($attention) { ?>
<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($success) { ?>
<!-- <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div> -->
<?php } ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger" ><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>

<!-- Content -->
<div class="content" id="content">
    <div class="container-fluid">
        <div class="title-catalog">
            <h1 class="">
                <?php echo $heading_title; ?>
                <?php if ($weight) { ?>
                &nbsp;(<?php echo $weight; ?>)
                <?php } ?>
            </h1>
        </div>
        <div class="row justify-content-start">

            <?php if ($column_left) { ?>
                <!-- sidebar -->
                <div id="column-left" class="col-lg-2">
                    <?php echo $column_left; ?>
                </div>
                <!-- sidebar end-->
            <?php } ?>

            <!-- page-cart -->
            <div class="page-cart col-lg-10 col-md-8 ">
                <div class="page-cart container-fluid">
                    <div class="row">
                        <div class="col-12 col-md-6">
                            <form class="order-form form-horizontal" id="send_order">
                                <div class="form-group row">
                                    <label for="inputname" class="col-12 col-sm-3 col-md-4 control-label">Имя *</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <input type="text" class="form-control rounded-0" id="inputname" name="name" placeholder="Иван" required>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="inputtel" class="col-12 col-sm-3 col-md-4 control-label">Телефон *</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <input type="text" class="form-control rounded-0" id="inputtel" name="phone" placeholder="+38 050 000 00 00" required>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="inputemail" class="col-12 col-sm-3 col-md-4 control-label">Email</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <input type="email" class="form-control rounded-0" id="inputemail" name="email" placeholder="info@gmail.com">
                                    </div>
                                </div>
                                <?php if (!empty($shipping_methods)){?>
                                <div class="form-group row">
                                    <label for="city" class="col-12 col-sm-3 col-md-4 control-label"><?=$text_shipping_methods?></label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <select class="form-control rounded-0" id="shipping_code" name="shipping_code">
                                            <option value="0" <?php if(!$checked_shipping_method){echo 'selected="selected"';} ?>
                                                ><?=$text_select_shipping_method?></option>
                                            <?php foreach ($shipping_methods as $shipping_method) {
                                                foreach ($shipping_method['quote'] as $sub_shipping_method) {?>
                                                <option value="<?=$sub_shipping_method['code']?>"
                                                    <?php if($checked_shipping_method === $sub_shipping_method['code']){echo 'selected="selected"';} ?>
                                                        ><?=$shipping_method['title']?></option>
                                            <?php }} ?>
                                        </select>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php /*
                                 * Nova Poshta
                                 *  */?>
                                <div class="form-group row nova-poshta">
                                    <label for="city" class="col-12 col-sm-3 col-md-4 control-label">Город</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <input type="text" class="form-control rounded-0" id="city" name="city_name" placeholder="Введите город">
                                        <input type="hidden" name="city" value="<?=$checked_np_city?>">
                                    </div>
                                </div>
                                <div class="form-group row nova-poshta">
                                    <label for="department" class="col-12 col-sm-3 col-md-4 control-label">Отделение Новой почты</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <select class="form-control rounded-0" id="department" name="department">
                                            <option  <?php if(!$checked_np_department){echo 'selected="selected"';} ?>
                                                value="0">Выберите отделение</option>
                                            <?php foreach ($np_departments as $np_department) {?>
                                                <option value="<?=$np_department['Ref']?>"
                                                    <?php if($np_department['Ref'] == $checked_np_department){echo 'selected="selected"';} ?>
                                                        ><?=$np_department['DescriptionRu']?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row locations">
                                    <label for="location" class="col-12 col-sm-3 col-md-4 control-label">Наши магазины</label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                            <?php foreach ($locations as $location) {?>
                                            <label >
                                                <input name="location" type="radio" value="<?=$location['location_id']?>"
                                                            >
                                                <?=$location['address']?>
                                                </label>
                                            <?php } ?>
                                    </div>
                                </div>
                                <?php  /*
                                 *
                                 */ ?>

                                <div class="form-group row">
                                    <label for="inputcomment" class="col-12 col-sm-3 col-md-4 control-label"><?=$text_comment?></label>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <textarea id="inputcomment" class="form-control rounded-0"  name="comment" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-sm-3 col-md-4"></div>
                                    <div class="col-12 col-sm-9 col-md-8">
                                        <button type="button" class="btn-cart btn-cart-block d-flex justify-content-center align-items-center" id="order_button">Оформить заказ</button>
                                    </div>
                                </div>
                                <div class="row">
                                 <div class="col-12">
                                <p><?=$order_description?></p>
                                 </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="my-order">
                                <div class="title d-flex justify-content-center"><h4><?=$text_your_order?></h4></div>
                                <form action="<?php echo $action; ?>" id="bform" method="post" enctype="multipart/form-data">
                                    <ul>
                                        <?php foreach ($products as $product) { ?>
                                        <li>
                                            <div class="cancel-order" data-toggle="modal" data-target="#cancel-modal" onclick="setRemoveItemData('<?php echo $product['cart_id']; ?>')"><i class="fa fa-times" aria-hidden="true"></i></div>
                                            <div class="row">
                                                <div class="col-sm-3 col-12">
                                                    <div class="thumbnail d-flex justify-content-center align-items-center"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"></div>
                                                </div>
                                                <div class="col-sm-9 col-12">
                                                    <div class="info">
                                                        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                                        <div class="code"><span>Код: <?php echo $product['model']; ?></span></div>
                                                        <div class="count-price">
                                                            <div class="row">
                                                                <div class="count-box col-sm-6">
                                                                    <span>Количество</span><input type="number" onchange="$('#bform').submit();" name="quantity[<?php echo $product['cart_id']; ?>]" size="5"  max="10" style="width: 40px" value="<?php echo $product['quantity']; ?>"> <span>шт.</span>
                                                                </div>
                                                                <div class="price col-sm-6"><span><?php echo $product['total']; ?> </span></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <?php } ?>
                                    </ul>
                                </form>
                                <div class="pay row">
                                    <div class="col-12 text-right">
                                        <span>К оплате:</span>

                                        <?php foreach ($totals as $key=> $total) { ?>
                                        <?php if($key==0){?>
                                    <div class="total d-inline-block">
                                        <span><?php echo $total['text']; ?></span>
                                    </div>
                                <?php } ?>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- page-cart end-->
            <div class="buttons clearfix hidden d-none">
                <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn-tai-white continue"><?php echo $button_shopping; ?></a></div>
            </div>
            <?php if ($column_right) { ?>
                <div id="column-right" class="col-lg-2">
                    <?php echo $column_right; ?>
                </div>
            <?php } ?>

        </div>
    </div>

    <?php if ($content_bottom) { ?>
        <div id="content-bottom">
            <?php echo $content_bottom; ?>
        </div>
    <?php } ?>

</div>
<!-- Content end-->

<script type="text/javascript">

    $('#shipping_code').on('change', function(){
        $('div.nova-poshta, div.locations').hide();
        $('div.nova-poshta, div.locations').hide();
        switch($(this).val()){
            case 'np.np':
                $('div.nova-poshta').show();
                break;
            case 'pickup.pickup':
                $('div.locations').show();
                break;
        }


    }).trigger('change');


    var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;

    $(function() {
        if($('input[name=\'city_name\']').length){

            $('input[name=\'city_name\']').autocomplete({
                'source': function(request, response) {
                    $.ajax({
                        url: 'index.php?route=checkout/cart/autocomplete&name=' +  encodeURIComponent(request),
                        dataType: 'json',
                        success: function(json) {
                            response($.map(json, function(item) {
                                return {
                                    label: item['DescriptionRu'],
                                    value: item['Ref']
                                }
                            }));
                        }
                    });
                },
                'select': function(item) {
                    $('input[name=\'city_name\']').val(item['label']);
                    $('input[name=\'city\']').val(item['value']);
                    changeDepartment(item['value']);
                }
            });





        }
    });
    function changeDepartment(ref)
    {
        var json = {
                        'city' : {
                            'ref' : ref
                        }
                    };
        $.ajax({
            url: 'index.php?route=checkout/cart/department',
            type: 'post',
            data: json,
            dataType: 'json',
            beforeSend: function () {
                $('#button-confirm').attr('disabled', true);
            },
            complete: function () {
                $('#button-confirm').attr('disabled', false);
            },
            success: function (json) {
                var html = '';

                html += '<option value="0">Выберите отделение</option>';
                $.each(json['departments'], function(key, value){
                    html += '<option value="' + value['Ref'] + '">' + value['DescriptionRu'] + '</option>';
                });

                $('#department').html(html);
            }
        });

    }

    function setRemoveItemData(_cart_id)
    {
        var cart_id = parseInt(_cart_id);
        $('#cancel-modal input[type="hidden"][name="cart_id"]').val(cart_id);
    }
    function removeItem()
    {
        var cart_id = parseInt($('#cancel-modal input[type="hidden"][name="cart_id"]').val());
        $('#cancel-modal').modal("hide");
        cart.remove(cart_id, true, function(json){
            var a = location;
            location =  a;

        });
    }

    $("#inputname, #inputtel").on("blur", function () {
        if ($(this).val() != '' && $(this).val() != '___ __-__-___')
        {
            $(this).css("border", "1px solid #DEDFDF");
        } else
        {
            $(this).css("border", "1px solid red");
        }
    });
    $("#inputemail").on("blur", function () {
        if ($(this).val() != '' && pattern.test($(this).val()))
        {
            $(this).css("border", "1px solid #DEDFDF");
        } else
        {
            if ($(this).val() != '')
            {
                $(this).css("border", "1px solid red");
            } else
            {
                $(this).css("border", "1px solid #DEDFDF");
            }
        }
    });
    $("#shipping_code").on("blur", function () {
        if ($(this).val() !== "0")
        {
            $(this).css("border", "1px solid #DEDFDF");
        } else
        {
            $(this).css("border", "1px solid red");
        }
    });

//    jQuery(function ($) {
//
//      $.mask.definitions['~']='[+-]';
//      $('#inputtel').mask('999 99-99-999');
//
//    });

    $('#order_button').bind('click', function () {

        var error = false, fn = $("#inputname").val(), ln = $("#inputtel").val(), em = $("#inputemail").val();

        if (fn == ''){
            $("#inputname").css("border","1px solid red");
            error=true;
        }
        if (ln == '' || ln == '+___ __-__-___'){
            $("#inputtel").css("border","1px solid red");
            error=true;
        }
        if (em != '' && !pattern.test(em)){
            $("#inputemail").css("border","1px solid red");
            error=true;
        }


        if($("#shipping_code").val() === "0"){
            $("#shipping_code").css("border","1px solid red");
            error=true;
        } else {
            if($("#shipping_code").val() === "pickup.pickup" && !$('[name="location"]:visible:checked').length){
                $('div.locations > label').css("border","1px solid red");
                error=true;
            }
        }
        if (!error)
        {
            var json = {
                'name' : fn,
                'phone' : ln,
                'email' : em
            },
            $comment = $('[name="comment"]'),
            $city = $('[name="city"]'),
            $city_name = $('[name="city_name"]'),
            $shipping_code = $('[name="shipping_code"]'),
            $department = $('[name="department"]');
            $location = $('[name="location"]:visible:checked');
            if($comment.length){
                json.comment = $comment.val();
            }
            if($shipping_code.length){
                json.shipping_code = $shipping_code.val();
            }

            if($city_name.length){
                json.city_name = $city_name.val();
            }
            if($city.length){
                json.city = $city.val();
            }
            if($department.length){
                json.department = $department.val();
            }
            if($location.length){
                json.location = $location.val();
            }

            $.ajax({
                url: 'index.php?route=checkout/cart/short',
                type: 'post',
//                data: $('#send_order :input'),
                data: json,
                dataType: 'json',
                beforeSend: function () {
                    $('#button-confirm').attr('disabled', true);
                },
                complete: function () {
                    $('#button-confirm').attr('disabled', false);
                },
                success: function (json) {
                    location = json['success'];
                }
            });
        }
    });

    $(document).ready(function() {
        $("#inputtel").mask("+38 999 999 99 99");
    });
</script>
<div class="modal fade" id="cancel-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <p>Вы действительно хотите удалить товар из корзины?</p>
                <div class="buttons-box d-flex justify-content-around">
                    <input type="hidden" value="" name="cart_id">
                    <button type="button" class="btn-cart btn-invert" onclick="removeItem()">Да</button>
                    <button type="button" class="btn-cart" data-dismiss="modal">Нет</button>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>