class Shopping::BaseController < ApplicationController
  
  # these are methods that can be used for all orders
  private
  
  def next_form(order)
    
       # if cart is empty
    if session_cart.cart_items.empty?
      flash[:notice] = 'You don\'t have anything in your cart'
      return root_url

       ## If we are insecure
    elsif !current_user || 
        session[:authenticated_at].nil? ||
        (Time.now - session[:authenticated_at] > (60 * 20) ) || ## 20 minutes
        (cookies[:insecure].nil? || cookies[:insecure] == true)## this should happen every time the user goes to a non-SSL page
      session[:return_to] = shopping_orders_url
      return login_url()
    elsif find_or_create_order.ship_address_id.nil?
      return shopping_addresses_url()
    elsif find_or_create_order.ship_method_id.nil?
      return shopping_shipping_methods_url()
    end
  end
  
  def find_or_create_order
    return @session_order if @session_order
    if session[:order_id]
      @session_order = current_user.orders.find(session[:order_id])
      if !@session_order.in_progress?
        @session_order = current_user.orders.create(:ip_address => request.env['REMOTE_ADDR'], 
                                                    :bill_address => current_user.bill_address  )
        session[:order_id] = @session_order.id
      end
    else
      @session_order = current_user.orders.create(:ip_address => request.env['REMOTE_ADDR'], 
                                                  :bill_address => current_user.bill_address)
      session[:order_id] = @session_order.id
    end
    @session_order
  end
end