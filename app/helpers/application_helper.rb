module ApplicationHelper
  
  
  def fieldset_container(model, method, options = {}, &block)
    unless error_message_on(model, method).blank?
      options[:class] ||= ''
      options[:class] = options[:class] + ' fieldWithErrors'
    end
    debugger
    html = content_tag('fieldset', capture(&block), options)
    concat(html)
  end
  
  ##############################################################################
  # Overrides submit_tag for disable save after click event  --
  ##############################################################################
  def commit_tag(value,options={})
    options.stringify_keys!
    submit_tag value, options.merge(:onclick => '

     if(window.addEventListener)
     {
       this.disabled = true;
     }
     else
     { // IE
       var element = window.event.srcElement;
       var  tag = element.tagName.toLowerCase();
      if(tag == "input")
       {
         var click = element.onclick;
         var keypress = element.onkeypress;
         setTimeout(function() { element.disabled = true; element.onclick = null; element.onkeypress = null; }, 0);
         setTimeout(function() { element.disabled = false; element.onclick = click; element.onkeypress =keypress; }, 50000);
       }
     }
     ')
  end
end
