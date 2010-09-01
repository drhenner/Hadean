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
    else
      return shopping_address_url
    end
  end
  
  def find_or_create_order
    if session[:order_id]
      @order = current_user.orders.find(session[:order_id])
      if !@order.in_progress?
        @order = current_user.orders.create
        session[:order_id] = @order.id
      end
    else
      @order = current_user.orders.create
      session[:order_id] = @order.id
    end
  end
end