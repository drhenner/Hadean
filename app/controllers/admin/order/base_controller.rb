class Admin::Order::BaseController < Admin::BaseController
  helper_method :session_admin_order, :session_admin_order_id
  
  private
  
  
  def session_admin_cart
    session[:admin_cart] ? session[:admin_cart] : new_admin_cart
  end
  
  def new_admin_cart
    {
      user_id             => nil,
      shipping_address_id => nil,
      billing_address_id  => nil,
      coupon_id           => nil,
      shipping_method_id  => nil,
      variants => {}# the key is variant_id, a hash of {shipping_rate_id, quantity, tax_rate_id, total}
    }
  end
end