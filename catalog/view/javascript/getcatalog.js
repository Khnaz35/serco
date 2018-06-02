function getcatalog_confirm() {
	var success = 'false';
    
    $.ajax({
        url: 'index.php?route=common/getcatalog',
        type: 'post',
        data: $('#getcatalog_data').serialize() + '&action=send',
        dataType: 'json',
        beforeSend: function() {
            $('#getcatalog_data').addClass('maskPopupGetcatalog');
            $('#getcatalog_data').after('<span class="loading_get_catalog"><i class="fa fa-circle-o-notch fa-spin fa-2x fa-fw"></i></span>');	
        },
        success: function(json) {					
            $('#contact-email').removeClass('error_input');
            $('.loading_get_catalog').remove();
            $('#getcatalog_data').removeClass('maskPopupGetcatalog');
            $('.text-danger').empty();
            
            if (json['error']) {
                if (json['error']['email_error']) {						
				    $('#contact-email').attr('placeholder',json['error']['email_error']);
                    $('#contact-email').addClass('error_input');
                }
            }
            
            if (json['success']){ 	
				$.magnificPopup.close();
                
                html = '<div id="modal-getcatalog" class="modal fade"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Внимание!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['success'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">Закрыть</button></div><div class="clearfix"></div></div></div>	</div></div></div>';
				
                $('body').append(html);

				$('#modal-getcatalog').modal('show');
            }	
        }

    });
}