<script type="text/javascript">
$.magnificPopup.close();
html = '<div id="modal-getprice" class="modal fade"><div class="modal-dialog" style="overflow:hidden"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><i class="fa fa-times" aria-hidden="true"></i></span><span class="sr-only">Закрыть</span></button><div class="modal-title">Ошибка!</div></div><div class="modal-body"><div class="text-center"><div class="popup-name">' + json['error'] + '</div><br></div><div class="text-center"><div class="popup-btn-center"><button data-dismiss="modal" class="btn btn-default">Закрыть</button></div><div class="clearfix"></div></div></div>	</div></div></div>';
				
$('body').append(html);

$('#modal-getprice').modal('show');
</script>