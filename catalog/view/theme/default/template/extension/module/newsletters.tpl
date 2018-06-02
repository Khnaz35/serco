<div class="container">
    <div class="row">
        <div class="box-newsletter">
        	<form action="" method="post" class="form-inline" class="newsletter">
                <ul class="newsletters">
                    <li><h3>Newsletter</h3></li>                          
                    <li><div class="input-group"><div class="input-group-addon">@</div><input type="email" name="txtemail" id="txtemail" value="" placeholder="" class="form-control input-lg"  /> </div><p><? echo $entry_submit;?></p></li> 
                    <li><div class="col-md-3"><button type="submit" class="newsletter btn btn-primary btn-lg" onclick="return subscribe();"><? echo $button_submit;?></button></div></li>
                </ul>
            </form>
        </div>
    </div>
</div>
<style>
    .newsletters{
        width: 100%;
        font-size: 0;
    }
    .newsletters,
    .newsletters li{
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .newsletters li{
       float: left;
       line-height: 44px;
       font-size: 12px;
       margin-right: 10px;
   }
   .newsletters li:nth-child(even){
    line-height: 18px;
}
.newsletters .col-md-9,
.newsletters .col-md-3{
    text-align: center;
}
.newsletters p{
    display: block;
    text-align: start;
}
.newsletters .input-group{
    width: 100%;
    display: table;        
}
</style>
<script>
    function subscribe()
    {
        var emailpattern = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}(.[a-zA-Z]{2})?$/;
        var email = $('#txtemail').val();     

        if(email != "")
        {
            if(emailpattern.test(email)){
                $.ajax({
                    type: 'POST',
                    url: 'index.php?route=extension/module/newsletters/newSubscribe',
                    dataType: 'json',
                    data: {email: $('#txtemail').val()},
                    success: function(data){ alert(data.message);}
                });
                $('#txtemail').val('');
                return false;
            }else{
                alert("Invalid Email");
                return false;
            }
        }
        else
        {
            alert("Email Is Require");
            $(email).focus();
            return false;
        }
    }
</script>