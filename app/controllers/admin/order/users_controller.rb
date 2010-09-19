class Admin::Order::UsersController < ApplicationController
  # GET /admin/order/users
  # GET /admin/order/users.xml
  def index
    @admin_order_users = Admin::Order::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_order_users }
    end
  end

  # GET /admin/order/users/1
  # GET /admin/order/users/1.xml
  def show
    @admin_order_user = Admin::Order::User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_order_user }
    end
  end

  # GET /admin/order/users/new
  # GET /admin/order/users/new.xml
  def new
    @admin_order_user = Admin::Order::User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_order_user }
    end
  end

  # GET /admin/order/users/1/edit
  def edit
    @admin_order_user = Admin::Order::User.find(params[:id])
  end

  # POST /admin/order/users
  # POST /admin/order/users.xml
  def create
    @admin_order_user = Admin::Order::User.new(params[:admin_order_user])

    respond_to do |format|
      if @admin_order_user.save
        format.html { redirect_to(@admin_order_user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @admin_order_user, :status => :created, :location => @admin_order_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/users/1
  # PUT /admin/order/users/1.xml
  def update
    @admin_order_user = Admin::Order::User.find(params[:id])

    respond_to do |format|
      if @admin_order_user.update_attributes(params[:admin_order_user])
        format.html { redirect_to(@admin_order_user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/users/1
  # DELETE /admin/order/users/1.xml
  def destroy
    @admin_order_user = Admin::Order::User.find(params[:id])
    @admin_order_user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_users_url) }
      format.xml  { head :ok }
    end
  end
end
