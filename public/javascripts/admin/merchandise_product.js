var Hadean = window.Hadean || {};


Hadean.Utility = {
  registerOnLoadHandler : function(callback) {
    jQuery(window).ready(callback);
  }
}


Hadean.AdminMerchandiseProductForm = {
    
    productCheckboxesDiv  : '#product_properties',
    prototypeSelectId     : '#select-prototype',
    formController        : '/admin/merchandise/products',
    productId             : null,
    
    initialize : function(product_Id) {

      this.productId  = product_Id;
      var prototype       = jQuery(Hadean.AdminMerchandiseProductForm.prototypeSelectId);
      prototype.
              bind('change',
                function() { 
                  Hadean.AdminMerchandiseProductForm.addProperties(
                    jQuery(Hadean.AdminMerchandiseProductForm.prototypeSelectId + " option:selected").first().val()
                  ) 
                }
              );
    }, 
    addProperties : function(id) {
      if ( typeof id == 'undefined' || id == 0 ) {
        //  Remove properties...

        jQuery(Hadean.AdminMerchandiseProductForm.productCheckboxesDiv).html('');
      }
      else {
        jQuery.ajax( {
           type : "GET",
           url : MerchProductForm.formController+'/'+id+"/add_properties",
           data : { product_id : Hadean.AdminMerchandiseProductForm.productId },
           complete : function(htmlText) {
             // open dialog with html
             Hadean.AdminMerchandiseProductForm.refreshProductForm(htmlText);
            // STOP  WAIT INDICATOR...
           },
           dataType : 'html'
        });
      }
    },
    refreshProductForm : function(htmlText) {
      // SHow the properties that are associated to this product

      jQuery(MerchProductForm.productCheckboxesDiv).html(htmlText.responseText);
      // Show the save button

    }
}

MerchProductForm = Hadean.AdminMerchandiseProductForm