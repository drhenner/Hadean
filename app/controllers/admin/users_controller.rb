class Admin::UsersController < Admin::BaseController
  
  def index 
    @users = User.find( :all, 
                        :include => [:registration_info])
    
  end
end
