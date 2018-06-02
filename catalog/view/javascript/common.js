function getURLVar(key) {
    var value = [];

    var query = document.location.search.split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }

        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}


$(document).ready(function() {

    $( ".header-search" ).click(function() {
        $('.search-fixed').addClass('opened');
    });

    $( ".search-close" ).click(function() {
        $('.search-fixed').removeClass('opened');
    });

    $('.submenu > li').matchHeight();

    $("#menu").mmenu({
        "extensions": [
            "pagedim-black",
            "theme-white"
        ],
        "navbar": {
             "title": false
        },
        "navbars": [
            {
                "position": "bottom",
                "content": [
                    "<a class='fa fa-envelope' href='#/'></a>",
                    "<a class='fab fa-instagram' href='#/'></a>",
                    "<a class='fab fa-facebook-f' href='#/'></a>"
                ]
            }
        ]
    });

    // Highlight any found errors
    $('.text-danger').each(function() {
        var element = $(this).parent().parent();

        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });

    // Currency
    $('#form-currency .currency-select').on('click', function(e) {
        e.preventDefault();

        $('#form-currency input[name=\'code\']').val($(this).attr('name'));

        $('#form-currency').submit();
    });

    // Language
    $('#form-language .language-select').on('click', function(e) {
        e.preventDefault();

        $('#form-language input[name=\'code\']').val($(this).attr('name'));

        $('#form-language').submit();
    });

    /* Search */
    $('#search input[name=\'search\']').parent().find('button').on('click', function() {
        var url = $('base').attr('href') + 'index.php?route=product/search';

        var value = $('#search input[name=\'search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('#search input[name=\'search\']').on('keydown', function(e) {
        if (e.keyCode == 13) {
            $('#search input[name=\'search\']').parent().find('button').trigger('click');
        }
    });

    /* Search */
    $('#menu input[name=\'m_search\']').parent().find('a').on('click', function() {
        var url = $('base').attr('href') + 'index.php?route=product/search';

        var value = $('#menu input[name=\'m_search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('#menu input[name=\'m_search\']').on('keydown', function(e) {
        if (e.keyCode == 13) {
            $('#menu input[name=\'m_search\']').parent().find('a').trigger('click');
        }
    });

    // Menu
    $('#menu .dropdown-menu').each(function() {
        var menu = $('#menu').offset();
        var dropdown = $(this).parent().offset();

        var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 10) + 'px');
        }
    });

    // Product List
    $('#list-view').click(function() {
        $('#content .product-grid > .clearfix').remove();

        $('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');
        $('#grid-view').removeClass('active');
        $('#list-view').addClass('active');

        localStorage.setItem('display', 'list');
    });

    // Product Grid
    $('#grid-view').click(function() {
        // What a shame bootstrap does not take into account dynamically loaded columns
        var cols = $('#column-right, #column-left').length;

        if (cols == 2) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
        } else if (cols == 1) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
        } else {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
        }

        $('#list-view').removeClass('active');
        $('#grid-view').addClass('active');

        localStorage.setItem('display', 'grid');
    });

    if (localStorage.getItem('display') == 'list') {
        $('#list-view').trigger('click');
        $('#list-view').addClass('active');
    } else {
        $('#grid-view').trigger('click');
        $('#grid-view').addClass('active');
    }

    // Checkout
    $(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
        if (e.keyCode == 13) {
            $('#collapse-checkout-option #button-login').trigger('click');
        }
    });

    // tooltips on hover
    $('[data-toggle=\'tooltip\']').tooltip({container: 'body',trigger: 'hover'});

    // Makes tooltips work on ajax generated content
    $(document).ajaxStop(function() {
        $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
    });
});

// Cart add remove functions
var cart = {
    'add': function(product_id, quantity, product_option_id, product_option_value_id) {
        var post_data = 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1);
        if(product_option_id != undefined && product_option_value_id != undefined){
            post_data += '&option['+product_option_id+']=' + product_option_value_id;
        }
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: post_data,
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            complete: function() {
                $('#cart > button').button('reset');
            },
            success: function(json) {
                $('.alert, .text-danger').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {

                    $('#content').parent().before('<div id="modal-addcart" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">' + json['success'] + '</div></div><div class="modal-body"><div class="text-center"><img style="margin:10px 0px;" src="'+ json['image_cart'] +'"  /><br></div><div class="text-center"><div class="popup-name">' + json['success_name'] + '</div><br></div><div class="text-center"><div class="popup-btn-left"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="popup-btn-right"><a href=' + link_checkout + ' class="btn btn-primary">'+ button_checkout +'</a></div><div class="clearfix"></div></div></div>    </div></div></div>');
                    $('#modal-addcart').modal('show');


                    setTimeout(function () {
                        $('#header-cart').attr('class', 'header-cart-ful');
                        $('#header-cart i.fa-shopping-bag').attr('class', 'fas fa-shopping-bag');
                        $('#header-cart .count-shoping').text(json['total_items']);
                    }, 100);

                    // Need to set timeout otherwise it wont update the total
                    /*setTimeout(function () {
                        //$('#cart').html('<span id="cart-total">' + json['text_total_items'] + '</span>');
                        $('.header-cart-container').load('index.php?route=common/cart/info');
                        $('.header-cart_fixed-container').load('index.php?route=common/cart_fixed/info');
                    }, 100);*/
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'update': function(key, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/edit',
            type: 'post',
            data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            complete: function() {
                $('#cart > button').button('reset');
            },
            success: function(json) {
                if(!json['total_items']){
                    setTimeout(function () {
                        $('#header-cart').attr('class', 'header-cart');
                        $('#header-cart i.fa-shopping-bag').attr('class', 'fal fa-shopping-bag');
                        $('#header-cart .count-shoping').text('');
                    }, 100);
                }else{
                    $('#header-cart .count-shoping').text(json['total_items']);
                }
                // Need to set timeout otherwise it wont update the total
                /*setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);*/

                /*if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    //$('#cart > ul').load('index.php?route=common/cart/info ul li');
                    //$('#cart_fixed > ul').load('index.php?route=common/cart_fixed/info ul li');
                        $('.header-cart-container').load('index.php?route=common/cart/info');
                        $('.header-cart_fixed-container').load('index.php?route=common/cart_fixed/info');
                }*/
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function(key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            complete: function() {
                $('#cart > button').button('reset');
            },
            success: function(json) {

                if(!json['total_items']){
                    setTimeout(function () {
                        $('#header-cart').attr('class', 'header-cart');
                        $('#header-cart i.fa-shopping-bag').attr('class', 'fal fa-shopping-bag');
                        $('#header-cart .count-shoping').text('');
                    }, 100);
                }else{
                    $('#header-cart .count-shoping').text(json['total_items']);
                }

                // Need to set timeout otherwise it wont update the total
                /*setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);*/
/*
                var now_location = String(document.location.pathname);

                if ((now_location == '/cart/') || (now_location == '/checkout/') || (getURLVar('route') == 'checkout/cart') || (getURLVar('route') == 'checkout/checkout')) {
                    location = 'index.php?route=checkout/cart';
                } else {
                    //$('#cart > ul').load('index.php?route=common/cart/info ul li');
                    //$('#cart_fixed > ul').load('index.php?route=common/cart_fixed/info ul li');
                        $('.header-cart-container').load('index.php?route=common/cart/info');
                        $('.header-cart_fixed-container').load('index.php?route=common/cart_fixed/info');
                }*/
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}

var voucher = {
    'add': function() {

    },
    'remove': function(key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function() {
                $('#cart > button').button('loading');
            },
            complete: function() {
                $('#cart > button').button('reset');
            },
            success: function(json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}

var wishlist = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=account/wishlist/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                $('.alert').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#content').parent().before('<div id="modal-addwishlist" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">' + json['success'] + '</div></div><div class="modal-body"><div class="text-center"><img style="margin:10px 0px;" src="'+ json['image_wishlist'] +'"  /><br></div><div class="text-center"><div class="popup-name">' + json['success_name'] + '</div><br></div><div class="text-center"><div class="popup-btn-left"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="popup-btn-right"><a href=' + link_wishlist + ' class="btn btn-primary">'+ button_wishlist +'</a></div><div class="clearfix"></div></div></div>    </div></div></div>');
                    $('#modal-addwishlist').modal('show');

                    //$('#wishlist-total span').html(json['total']);
                    $('#wishlist-total').attr('title', json['total']);
                }

                //$('html, body').animate({ scrollTop: 0 }, 'slow');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {

    }
}

var compare = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=product/compare/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                $('.alert').remove();

                if (json['success']) {
                    $('#content').parent().before('<div id="modal-addcompare" class="modal"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">' + json['success'] + '</div></div><div class="modal-body"><div class="text-center"><img style="margin:10px 0px;" src="'+ json['image_compare'] +'"  /><br></div><div class="text-center"><div class="popup-name">' + json['success_name'] + '</div><br></div><div class="text-center"><div class="popup-btn-left"><button data-dismiss="modal" class="btn btn-default">'+ button_shopping +'</button></div><div class="popup-btn-right"><a href=' + link_compare + ' class="btn btn-primary">'+ button_compare +'</a></div><div class="clearfix"></div></div></div>    </div></div></div>');
                    $('#modal-addcompare').modal('show');

                    $('#compare-total').html(json['total']);
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {

    }
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function(e) {
    e.preventDefault();

    $('#modal-agree').remove();

    var element = this;

    $.ajax({
        url: $(element).attr('href'),
        type: 'get',
        dataType: 'html',
        success: function(data) {
            html  = '<div id="modal-agree" class="modal">';
            html += '  <div class="modal-dialog">';
            html += '    <div class="modal-content">';
            html += '      <div class="modal-header">';
            html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
            html += '        <div class="modal-title">' + $(element).text() + '</div>';
            html += '      </div>';
            html += '      <div class="modal-body">' + data + '</div>';
            html += '    </div';
            html += '  </div>';
            html += '</div>';

            $('body').append(html);

            $('#modal-agree').modal('show');
        }
    });
});

// Autocomplete */
(function($) {
    $.fn.autocomplete = function(option) {
        return this.each(function() {
            this.timer = null;
            this.items = new Array();

            $.extend(this, option);

            $(this).attr('autocomplete', 'off');

            // Focus
            $(this).on('focus', function() {
                this.request();
            });

            // Blur
            $(this).on('blur', function() {
                setTimeout(function(object) {
                    object.hide();
                }, 200, this);
            });

            // Keydown
            $(this).on('keydown', function(event) {
                switch(event.keyCode) {
                    case 27: // escape
                        this.hide();
                        break;
                    default:
                        this.request();
                        break;
                }
            });

            // Click
            this.click = function(event) {
                event.preventDefault();

                value = $(event.target).parent().attr('data-value');

                if (value && this.items[value]) {
                    this.select(this.items[value]);
                }
            }

            // Show
            this.show = function() {
                var pos = $(this).position();

                $(this).siblings('ul.dropdown-menu').css({
                    top: pos.top + $(this).outerHeight(),
                    left: pos.left
                });

                $(this).siblings('ul.dropdown-menu').show();
            }

            // Hide
            this.hide = function() {
                $(this).siblings('ul.dropdown-menu').hide();
            }

            // Request
            this.request = function() {
                clearTimeout(this.timer);

                this.timer = setTimeout(function(object) {
                    object.source($(object).val(), $.proxy(object.response, object));
                }, 200, this);
            }

            // Response
            this.response = function(json) {
                html = '';

                if (json.length) {
                    for (i = 0; i < json.length; i++) {
                        this.items[json[i]['value']] = json[i];
                    }

                    for (i = 0; i < json.length; i++) {
                        if (!json[i]['category']) {
                            html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
                        }
                    }

                    // Get all the ones with a categories
                    var category = new Array();

                    for (i = 0; i < json.length; i++) {
                        if (json[i]['category']) {
                            if (!category[json[i]['category']]) {
                                category[json[i]['category']] = new Array();
                                category[json[i]['category']]['name'] = json[i]['category'];
                                category[json[i]['category']]['item'] = new Array();
                            }

                            category[json[i]['category']]['item'].push(json[i]);
                        }
                    }

                    for (i in category) {
                        html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

                        for (j = 0; j < category[i]['item'].length; j++) {
                            html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
                        }
                    }
                }

                if (html) {
                    this.show();
                } else {
                    this.hide();
                }

                $(this).siblings('ul.dropdown-menu').html(html);
            }

            $(this).after('<ul class="dropdown-menu"></ul>');
            $(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

        });
    }
})(window.jQuery);
