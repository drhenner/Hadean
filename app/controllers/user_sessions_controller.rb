class UserSessionsController < ApplicationController

  #layout 'session'
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      cookies[:hadean_uid] = @user_session.record.access_token
      session[:authenticated_at] = Time.now
      flash[:notice] = "Login successful!"
      redirect_back_or_default root_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    reset_session
    cookies.delete(:hadean_uid)
    flash[:notice] = "Logout successful!"
    redirect_to login_url
  end

  private

end
