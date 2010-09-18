class Admin::UsersController < Admin::BaseController
  
  def index 
   # @users = User.find( :all)
    authorize! :view_users, current_user
    
    @users = User.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @users.to_jqgrid_json(
        [ :first_name, :last_name, :email, :state ],
        @users.per_page, #params[:page],
        @users.current_page, #params[:rows],
        @users.total_entries)
      
      }
    end
    
  end
  
  def new
    authorize! :create_users, @user
    @user = User.new
    form_info
  end
  
  def create
    authorize! :create_users, @user
    @user = User.new(params[:user])
    if @user.save
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to admin_users_url
    else
      form_info
      render :action => :new
    end
  end
  
  def edit
    @user = User.includes(:roles).find(params[:id])
    form_info
  end
  
  def update
    params[:user][:role_ids] ||= []
    @user = User.includes(:roles).find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.name} has been updated."
      redirect_to admin_users_url
    else
      form_info
      render :action => :edit
    end
  end
  
  private
  
  def form_info
    @all_roles = Role.all
  end
end
