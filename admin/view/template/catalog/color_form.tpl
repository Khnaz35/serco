<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-banner" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-color" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <table id="colors" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $entry_product_name; ?></td>
                <td class="text-left"><?php echo $entry_color_name; ?></td>
                <td class="text-left"><?php echo $entry_color_code; ?></td>
                <td class="text-right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <tbody>
            <?php $language_id = -1; ?>
                <?php foreach ($languages as $language) { ?>
                    <?php if ($language_id < 0) { ?>
                        <?php $language_id = $language['language_id']; ?>
                    <?php } ?>
                <?php } ?>
              <?php $color_row = 0; ?>
              <?php foreach ($set_colors as $color) { ?>
              <tr id="color-row<?php echo $color_row; ?>">
                
                <td class="text-left" style="width: 40%;">
                    <input type="text" name="color[<?php echo $color_row; ?>][name]" value="<?php echo isset($color['product_info'][$language_id]) ? $color['product_info'][$language_id]['name'] : ''; ?>" placeholder="<?php echo $entry_product_name; ?>" class="form-control" />
                        
                    <div id="product_<?php echo $color_row; ?>_id">
                        <input type="hidden" name="color[<?php echo $color_row; ?>][product_id]" value="<?php echo $color['product_id']; ?>" />
                    </div>
                    
                    <?php if (isset($error_name[$color_row])) { ?>
                        <div class="text-danger"><?php echo $error_name[$color_row]; ?></div>
                    <?php } ?>
                    
                
                </td>
                
                
                <td class="text-left" style="width:20%;">
                
                    <ul class="nav nav-tabs" id="language<?php echo $color_row; ?>">
                        <?php foreach ($languages as $language) { ?>
                            <li><a href="#language<?php echo $color_row; ?><?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="tab-content">
                        <?php foreach ($languages as $language) { ?>
                            <div class="tab-pane" id="language<?php echo $color_row; ?><?php echo $language['language_id']; ?>">
                        
                                <input type="text" name="color[<?php echo $color_row; ?>][color_name][<?php echo $language['language_id']; ?>]" value="<?php echo $color['color_name'][$language['language_id']]; ?>" placeholder="<?php echo $entry_color_name; ?>" class="form-control" />
                            
                                <?php if (isset($error_color_name[$color_row][$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_color_name[$color_row][$language['language_id']]; ?></div>
                                <?php } ?>
                            </div>
                        <?php } ?>
                    </div>
              

                </td>
                <td class="text-left">
                    <?php /*<input class="jscolor form-control" type="text" name="color[<?php echo $color_row; ?>][color_code]" value="<?php echo $color['color_code']; ?>" placeholder="<?php echo $entry_color_code; ?>" />*/ ?>
                    
                    <a href="" id="thumb-image<?php echo $color_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $color['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                    <input type="hidden" name="color[<?php echo $color_row; ?>][color_image]" value="<?php echo $color['image']; ?>" id="input-image<?php echo $color_row; ?>" />
                
                    <?php if (isset($error_color_code[$color_row])) { ?>
                        <div class="text-danger"><?php echo $error_color_code[$color_row]; ?></div>
                    <?php } ?>
                </td>
                <td class="text-right">
                    <input type="text" name="color[<?php echo $color_row; ?>][sort_order]" value="<?php echo $color['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" />
                </td>
                <td class="text-left"><button type="button" onclick="$('#color-row<?php echo $color_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
              </tr>
                                
<script type="text/javascript"><!--
$('#language<?php echo $color_row; ?> a:first').tab('show');
//--></script>
              

              <?php $color_row++; ?>
              
              


              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="4"></td>
                <td class="text-left"><button type="button" onclick="addProductColor();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div> 

<script type="text/javascript"><!--
var color_row = <?php echo $color_row; ?>;

function addProductColor() {
	html  = '<tr id="color-row' + color_row + '">';
	html += '<td class="text-left"><input type="text" name="color[' + color_row + '][name]" value="" placeholder="<?php echo $entry_product_name; ?>" class="form-control" />';	

    html += '<div id="product_' + color_row + '_id">';
    html += '<input type="hidden" name="color[' + color_row + '][product_id]" value="" />';
    html += '</div>';
    html += '</td>';
    
//var jsID = "jscolor" + color_row;
//var onclickjsID = "var picker = new jscolor(document.getElementById('" + jsID + "'));"

    //html += '  <td class="text-left"><input type="text" name="color[' + color_row + '][color_name]" value="" placeholder="<?php echo $entry_color_name; ?>" class="form-control" /></td>';	
	
    
                html += '  <td class="text-left">';
                
                    html += '  <ul class="nav nav-tabs" id="language' + color_row + '">';
                        <?php foreach ($languages as $language) { ?>
                            var lang_id = "<?php echo $language['language_id']; ?>";
                            var lang_code = "<?php echo $language['code']; ?>";
                            var lang_name = "<?php echo $language['name']; ?>";
                            html += ' <li><a href="#language' + color_row + '-' + lang_id + '" data-toggle="tab"><img src="language/' + lang_code + '/' + lang_code + '.png" title="' + lang_name + '" /> ' + lang_name + '</a></li>';
                        <?php } ?>
                    html += '  </ul>';
                    html += '  <div class="tab-content">';
                        <?php foreach ($languages as $language) { ?>
                            var lang_id = "<?php echo $language['language_id']; ?>";
                            
                            html += '  <div class="tab-pane" id="language' + color_row + '-' + lang_id + '">';
                        
                                html += '<input type="text" name="color[' + color_row + '][color_name][' + lang_id + ']" value="" placeholder="<?php echo $entry_color_name; ?>" class="form-control" />';
                            
                            html += '  </div>';
                        <?php } ?>
                    html += '  </div>';
              

                html += '  </td>';
    
    
    
    
    //html += '  <td class="text-left"><input id="' + jsID + '" onclick="' + onclickjsID + '" class="jscolor" type="text" name="color[' + color_row + '][color_code]" value="FFFFFF" placeholder="<?php echo $entry_color_code; ?>" /></td>';	
	
html += '  <td class="text-left"><a href="" id="thumb-image' + color_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>';
html += '<input type="hidden" name="color[' + color_row + '][color_image]" value="" id="input-image' + color_row + '" /></td>';
                
    
    html += '  <td class="text-right"><input type="text" name="color[' + color_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#color-row' + color_row  + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#colors tbody').append(html);
	
    
    $('#language' + color_row + ' a:first').tab('show');
    
    set_autocomplete(color_row);
    
	color_row++;
}

function set_autocomplete(color_row) {
    $('input[name="color['+color_row+'][name]"]').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/color/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
     			dataType: 'json',			
     			success: function(json) {
                    response($.map(json, function(item) {
        				return {
        				    label: item['name'],
                            value: item['product_id']
        				}
                    }));
                }
            });
       	},
       	'select': function(item) {
      		$('input[name="color['+color_row+'][name]"]').val(item['label']);
      		$('#product_'+color_row+'_id').html('<input type="hidden" name="color['+color_row+'][product_id]" value="' + item['value'] + '" />');
        }	
    }); 
}

$('#colors tbody tr').each(function(index, element) {
	set_autocomplete(index);
});
//--></script> 

<script type="text/javascript"><!--
var color_row = <?php echo $color_row; ?>;

$('input[name="color['+color_row+'][name]"]').autocomplete({
    'source': function(request, response) {
        $.ajax({
            url: 'index.php?route=catalog/color/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
 			dataType: 'json',			
 			success: function(json) {
                response($.map(json, function(item) {
    				return {
    				    label: item['name'],
                        value: item['product_id']
    				}
                }));
            }
        });
   	},
   	'select': function(item) {
  		$('input[name="color['+color_row+'][name]"]').val(item['label']);
  		$('#product_'+color_row+'_id').html('<input type="hidden" name="color['+color_row+'][product_id]" value="' + item['value'] + '" />');
    }	
}); 

color_row++;
//--></script></div>

<?php echo $footer; ?>