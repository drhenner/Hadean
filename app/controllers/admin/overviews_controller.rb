class Admin::OverviewsController < ApplicationController
  # GET /admin/overviews
  # GET /admin/overviews.xml
  layout false
  
  def index
    #  The index action should 
    if u = User.first
      debugger
      u
      redirect_to root_url if !current_user || !current_user.admin?
      
    else
      ##  This means we don't have any users
      ##  First we need to create a user with all permissions
      @password = "admin_user_#{rand(1000)}"
      
      @user = User.new(:first_name => 'Admin', 
                       :last_name => 'User', 
                       :email => 'admin@notarealemail.com',
                       :password => @password,
                       :password_confirmation => @password)
      @user.role_ids = Role.all.collect{|r| r.id }
      if @user.activate!
      
        @user_session = UserSession.new(:email => @user.email, :password => @password)
        us = @user_session.save
        debugger
        @user_session
      end
    end
  end

end
