class Admin::UsersController < ApplicationController
  
  def index 
    @user = User.find(:all)
    
  end
end
