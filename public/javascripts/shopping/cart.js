var Hadean = window.Hadean || { };
Hadean.Utility = {
  registerOnLoadHandler : function(callback) {
    jQuery(window).ready(callback);
  }
};

Hadean.Cart = {
  NewForm : {
    newFormId : '#new_shopping_cart',
    addToCart : true,
    
    //Public methods
    initialize      : function() {
      jQuery('.add-to-cart').click( function() { 
          if (Hadean.Cart.NewForm.addToCart) {
            //jQuery(newFormId).submit();
            alert('check if form can be submitted  VARIANT ID ' + Hadean.Cart.NewForm.newFormId)
            Hadean.Cart.NewForm.addToCart = false;
          };
        } 
      )
    }
  }
}