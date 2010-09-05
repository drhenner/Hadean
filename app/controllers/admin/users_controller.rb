class Admin::UsersController < Admin::BaseController
  
  def index 
    @users = User.find( :all)
    
  end
end
