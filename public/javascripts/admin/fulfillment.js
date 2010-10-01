var Hadean = window.Hadean || {};


Hadean.Utility = {
  registerOnLoadHandler : function(callback) {
    jQuery(window).ready(callback);
  }
}

Hadean.Fulfillment = {
  captureInvoiceButton      : '#capture-invoice-button-',
  capturePartInvoiceButton  : '#capture-partial-invoice-button-',
  cancelInvoiceButton       : '#cancel-invoice-button-',
  
  initialize : function(invoiceId) {

    var captureTag      = jQuery(Hadean.Fulfillment.captureInvoiceButton + invoiceId );
    var capturePartTag  = jQuery(Hadean.Fulfillment.capturePartInvoiceButton + invoiceId);
    var cancelTag       = jQuery(Hadean.Fulfillment.cancelInvoiceButton + invoiceId);
    
    jQuery("#dialog").dialog({
      bgiframe: true, 
      autoOpen: false, 
      height: 190,
      width: 460,
      modal: true
    });
    
    captureTag.
            bind('click',
              function() { 
                // submit to collect all payments
              }
            );
            

    capturePartTag.
            bind('click',
              function() { 
                // submit to go to capture part form
                // capture part form has cancel order-items
              }
            );

    cancelTag.
            bind('click',
              function() { 
                // submit to go to cancel order and payment

                Hadean.Fulfillment.cancelInvoice(invoiceId);
              }
            );
  },//END of INITIALIZE
  cancelInvoice : function(invoiceId) {
    
    jQuery('#dialog').dialog( 'option', 
                              'buttons', 
                              [
                                {
                                  text: "Ok " + invoiceId,
                                  click: function() { $(this).dialog("close"); }
                                },
                                {
                                  text: "Close Dialog",
                                  click: function() { $(this).dialog("close"); }
                                }
                              ]
                            );
    
    jQuery('#dialog').dialog('open'); 
    return false;
    
  }// cancelInvoice
}
