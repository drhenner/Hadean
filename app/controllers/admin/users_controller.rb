class Admin::UsersController < ApplicationController
  
  def index 
    @users = User.find( :all, 
                        :include => [:registration_info])
    
  end
end
