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
  }
}