class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  helper_method :current_user, :current_user_id, :most_likely_user, :random_user, :session_cart
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  private
  
  def session_cart
    return @session_cart if defined?(@session_cart)
    if session[:cart_id]
      @session_cart = Cart.includes(:shopping_cart_items).find(session[:cart_id])
    elsif current_user && current_user.current_cart
      @session_cart = current_user.current_cart
      session[:cart_id] = @session_cart.id
    else
      @session_cart = Cart.create
      session[:cart_id] = @session_cart.id
    end
    @session_cart
  end
  
  ## The most likely user can be determined off the session / cookies or for now lets grab a random user
  #   Change this method for showing products that the end user will more than likely like.
  #   
  def most_likely_user
    current_user ? current_user : random_user
  end
  
  ## TODO cookie[:hadean_user_id] value needs to be encrypted ### Authlogic persistence_token might work here
  def random_user
    return @random_user if defined?(@random_user)
    @random_user = cookies[:hadean_user_id] ? User.find(cookies[:hadean_user_id]) : nil
  end
  
  ###  Authlogic helper methods
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def current_user_id
    return @current_user_id if defined?(@current_user_id)
    @current_user_id = current_user_session && current_user_session.record && current_user_session.record.id
  end
end
