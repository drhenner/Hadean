#The philosophy of the admin cart is 2-fold.
#
# First these people have admin privileges.  So lets not add security features that they are allowed to use anyway. 
#
# Second, the number of people in the Admin Section will not be in the millions.  
# => So lets use the mem_cache session store to store more information than we would normal.  
# => This will hit the DB much less and should have better performance.

class Admin::Order::BaseController < Admin::BaseController
  helper_method :session_admin_cart#, :new_admin_cart#, :reset_admin_cart
  
  private
  
  def reset_admin_cart
    session[:admin_cart] = new_admin_cart
  end
  
  def session_admin_cart
    session[:admin_cart] ? session[:admin_cart] : new_admin_cart
  end
  
  def new_admin_cart
    {
      :user             => nil,
      :shipping_address => nil,
      :billing_address  => nil,
      :coupon           => nil,
      :shipping_method  => nil,
      :variants => {}# the key is variant_id, a hash of {variant, shipping_rate, quantity, tax_rate, total}
    }
  end
  
  def next_admin_cart_form()
     # if cart is empty
    if session_admin_cart[:user].nil?
      return admin_order_users_url
    elsif session_admin_cart[:shipping_address].nil?
      return admin_order_shipping_addresses_url
    elsif session_admin_cart[:billing_address].nil?
      return admin_order_billing_addresses_url()
    elsif session_admin_cart[:shipping_method].nil?
      return admin_order_shipping_methods_url()
    else
      return nil#admin_order_carts_url()
#    elsif session_admin_cart[:coupon].nil?
#      return admin_order_coupons_url()
    end
  end
  
end