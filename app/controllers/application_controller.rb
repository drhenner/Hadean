class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  helper_method :current_user, :current_user_id, :most_likely_user, :random_user, :session_cart, :is_production_simulation
  before_filter :secure_session
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    if current_user && current_user.admin?
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  private
  
  def is_production_simulation
    false
  end
  
  def secure_session
    if Rails.env == 'production' || is_production_simulation
      if session_cart && !request.ssl?
        cookies[:insecure] = true
      else
        cookies[:insecure] = false
      end
    else
      cookies[:insecure] = false
    end
  end
  
  def session_cart
    return @session_cart if defined?(@session_cart)
    session_cart!
  end
  # use this method if you want to force a SQL query to get the cart.
  def session_cart!
    if cookies[:cart_id]
      @session_cart = Cart.includes(:shopping_cart_items).find(cookies[:cart_id])
    elsif current_user && current_user.current_cart
      @session_cart = current_user.current_cart
      cookies[:cart_id] = @session_cart.id
    else
      @session_cart = Cart.create
      cookies[:cart_id] = @session_cart.id
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
    @random_user = cookies[:hadean_uid] ? User.find_by_persistence_token(cookies[:hadean_uid]) : nil
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
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
