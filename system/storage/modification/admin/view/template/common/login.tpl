<?php echo $header; ?>
<style>
body{font-size:13px;}
#header{border:none; padding-top:50px;}
#header .navbar-header{float:none; text-align:center;}
.navbar-brand{float:none; display:block;}
.navbar-brand > img{display:inline-block;}
.form-group {padding-top:10px; padding-bottom:10px;}
.form-group + .form-group{border:none;}
.btn{font-size:16px; margin:20px 0px 20px; padding:11px 45px; border-radius:30px; border:none;}
.form-control{box-shadow:none; border-width:0px 0px 1px; padding-right:0px; padding-left:0px; font-size:15px; border-radius:0px;}
.form-control:hover, .form-control:focus{box-shadow:none; border-width:0px 0px 1px;}
@media (max-width: 767px) {
#header{padding-top:10px;}
#footer{height:auto;}
#content{padding-bottom:0px;}
}
		</style>
<div id="content">
  <div class="container-fluid">
    
    <div class="row">
      <div class="col-md-offset-4 col-md-4 col-sm-offset-3 col-sm-6">
        <div>
          <div class="panel-heading">
            <h1 class="panel-title text-center"> <?php echo $text_login; ?></h1>
          </div>
          <div class="panel-body">
            <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <input type="text" name="username" value="<?php echo $username; ?>" placeholder="<?php echo $entry_username; ?>" id="input-username" class="form-control" />
              </div>
              <div class="form-group">
                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
              </div>
              <div class="text-center">
                <button type="submit" class="btn btn-primary"> <?php echo $button_login; ?></button>
              </div>
              <?php if ($redirect) { ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php } ?>
<?php if ($forgotten) { ?>
                <span class="help-block text-center"><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></span>
                <?php } ?>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>