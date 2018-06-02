function subscribe() {
    $('#txtemail').removeClass('error');

    var emailpattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}(.[a-zA-Z]{2})?$/;
    var email = $('#txtemail').val();

    if(email != "") {
        if(emailpattern.test(email)){
            $.ajax({
                type: 'POST',
                url: 'index.php?route=extension/module/newsletters/newSubscribe',
                dataType: 'json',
                data: {email: $('#txtemail').val()},
                success: function(data){ alert(data.message); }
            });
            $('#txtemail').val('');
        } else {
            $('#txtemail').addClass('error');
        }
    }else {
        $('#txtemail').addClass('error');
        $(email).focus();
    }

    return false;
}