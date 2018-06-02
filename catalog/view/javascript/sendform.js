function sendform_confirm() {
	var success = 'false';
    
    $.ajax({
        url: 'index.php?route=information/information',
        type: 'post',
        data: $('#sendform_data').serialize() + '&action=send',
        dataType: 'json',
        beforeSend: function() {
            $('#sendform_data').addClass('maskPopupSendform');
            $('#sendform_data').after('<span class="loading_send_form"><i class="fa fa-circle-o-notch fa-spin fa-2x fa-fw"></i></span>');	
        },
        success: function(json) {	
            $('#sendform-name').removeClass('error_input');
            $('#sendform-phone').removeClass('error_input');
            $('.loading_send_form').remove();
            $('#sendform_data').removeClass('maskPopupSendform');
            
            if (json['warning']) {
                if (json['warning']['bot_catcher']) {						
				    alert(json['warning']['bot_catcher']);
                }
                if (json['warning']['name']) {						
				    $('#sendform-name').attr('placeholder',json['warning']['name']);
                    $('#sendform-name').addClass('error_input');
                }
                if (json['warning']['phone']) {						
				    $('#sendform-phone').attr('placeholder',json['warning']['phone']);
                    $('#sendform-phone').addClass('error_input');
                }
            }
            
            if (json['success']){ 	
                $('#sendform-name').val('');
                $('#sendform-phone').val('');
                $('#sendform-email').val('');
                $('#sendform-comment').val('');
                
				$.magnificPopup.close();
                
                html = '<div id="modal-sendform" class="modal fade"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Внимание!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['success'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">Закрыть</button></div><div class="clearfix"></div></div></div>	</div></div></div>';
				
                $('body').append(html);

				$('#modal-sendform').modal('show');
            }
        }

    });
}