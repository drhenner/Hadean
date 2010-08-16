class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  helper_method :current_user, :current_user_id
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  
  private

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
    @current_user_id = current_user_session && current_user_session.record.id
  end
end
