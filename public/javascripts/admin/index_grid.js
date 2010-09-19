var Hadean = window.Hadean || {};

Hadean.AdminIndexForm = {
  registerOnLoadHandler : function(callback) {
    jQuery(window).ready(callback);
  },
  initialize : function(controller) {
    this.formController = controller;
  }, 
  editSelection : function(id) {
    window.location.href = Hadean.AdminIndexForm.formController+'/'+id+"/edit";
  },
  userSelection : function(id) {
    //window.location.href = Hadean.AdminIndexForm.formController+'/'+id+"/edit";
    //Get the form element, inject the user_id and click submit.  
    jQuery('#admin-user_id').val(id);  
    jQuery('#admin-user-form').submit();
  }
}