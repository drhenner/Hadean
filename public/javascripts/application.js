
//THIS CODE WILL DISABLE ANY AUTOCOMPLETE for CSS class == disableAutoComplete
if (document.getElementsByTagName) {
  var inputElements = document.getElementsByTagName("input");
  for (i=0; inputElements[i]; i++) {
    if (inputElements[i].className && (inputElements[i].className.indexOf("disableAutoComplete") != -1)) {
      inputElements[i].setAttribute("autocomplete","off");
    }//if current input element has the disableAutoComplete class set.
  }//loop thru input elements
}//basic DOM-happiness-check
  
var Hadean = window.Hadean || {};

Hadean.App = {
  registerOnLoadHandler : function(callback) {
    jQuery(window).ready(callback);
  },
  oneClickHandler : function(callback, IdOrClass) {
    $(IdOrClass).click(function(e) { 
      e.preventDefault();
      jQuery(IdOrClass).attr('disabled', 'disabled');
      callback;
    }
  }
}

$(function() {
  $('form a.add_child').click(function() {
    var assoc   = $(this).attr('data-association');
    var content = $('#' + assoc + '_fields_template').html();
    var regexp  = new RegExp('new_' + assoc, 'g');
    var new_id  = new Date().getTime();
        
    $(this).parent().before(content.replace(regexp, new_id));    
    return false;
  });
  
  $('form a.remove_child').live('click', function() {
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).parents('.new_fields').remove();
    $(this).parents('.fields').hide();
    return false;
  });
});
