function checkFixedMenu(){
    
    var page = jQuery('body');
    
    var topPosValue = jQuery('#header-container').height() + parseInt(jQuery('#header-container').css('padding-top')) + parseInt(jQuery('#header-container').css('padding-bottom'));
    
    if (jQuery(window).scrollTop() > topPosValue) {
        if (!page.hasClass('page_has_fixed')) {
            page.addClass('page_has_fixed');
        }
    }
    else {
        if (page.hasClass('page_has_fixed')) {
            page.removeClass('page_has_fixed');
        }
    }
    
}

function leftMenuResize(){
    var windowHeight = $(window).height();
    $('.header-fixed-menu-container').css('height', windowHeight+'px');
}

function toggleLeftMenu(){
    
    var header_fixed_menu_back = $('.header-fixed-menu-back');
    
    if (!header_fixed_menu_back.hasClass('opened_menu')){
        header_fixed_menu_back.addClass('opened_menu');
        
        
        header_fixed_menu_back.bind('click.myEvent', function(e) {
                if ($(e.target).closest('.header-fixed-menu-container').length == 0) {
                    header_fixed_menu_back.removeClass('opened_menu');
                    header_fixed_menu_back.unbind('click.myEvent');
                }
        });
        
        
    }
    else {
        header_fixed_menu_back.removeClass('opened_menu');
    }
}

/*function windowWidthCheck(){
    var windowWdth = $(window).width();
    if (windowWdth < 992){
        if (!$('#header-menu').hasClass('opened_menu')) {
            $('.menu-container').slideUp();
        }
        else {
            $('.menu-container').slideDown();
        }
    }
    else {
        $('#header-menu').removeClass('opened_menu');
        $('.menu-container').slideDown();
    }
}*/

$(window).resize(function() {
    //windowWidthCheck();
    leftMenuResize();
    checkFixedMenu();
});

$(window).scroll(function(){
    checkFixedMenu();
});


$(document).ready(function() {
    
    //windowWidthCheck();
    leftMenuResize();
    checkFixedMenu();
    
	$('.mobile-menu-toggle i').click(function() {
		toggleLeftMenu();
	});
    
	$('.header-float-menu-toggle i').click(function() {
		toggleLeftMenu();
	});
    
	$('.mobile-menu-fixed-toggle i').click(function() {
		toggleLeftMenu();
	});
    
	$('.header-fixed-menu-close i').click(function() {
        toggleLeftMenu();
	});
}); 