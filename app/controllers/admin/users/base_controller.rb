class Admin::Users::BaseController < ApplicationController
  layout  "admin"
  
  def index
    @users  = User.find(:all, :include => [:active_name, :active_email])
  end

  def new
    @user   = User.new
    @name   = Name.new
    @email  = Email.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
