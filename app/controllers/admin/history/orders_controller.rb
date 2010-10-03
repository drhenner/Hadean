class Admin::History::OrdersController < ApplicationController
  # GET /admin/history/orders
  # GET /admin/history/orders.xml
  def index
    @admin_history_orders = Admin::History::Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_history_orders }
    end
  end

  # GET /admin/history/orders/1
  # GET /admin/history/orders/1.xml
  def show
    @admin_history_order = Admin::History::Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_history_order }
    end
  end

  # GET /admin/history/orders/new
  # GET /admin/history/orders/new.xml
  def new
    @admin_history_order = Admin::History::Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_history_order }
    end
  end

  # GET /admin/history/orders/1/edit
  def edit
    @admin_history_order = Admin::History::Order.find(params[:id])
  end

  # POST /admin/history/orders
  # POST /admin/history/orders.xml
  def create
    @admin_history_order = Admin::History::Order.new(params[:admin_history_order])

    respond_to do |format|
      if @admin_history_order.save
        format.html { redirect_to(@admin_history_order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @admin_history_order, :status => :created, :location => @admin_history_order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_history_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/history/orders/1
  # PUT /admin/history/orders/1.xml
  def update
    @admin_history_order = Admin::History::Order.find(params[:id])

    respond_to do |format|
      if @admin_history_order.update_attributes(params[:admin_history_order])
        format.html { redirect_to(@admin_history_order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_history_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/history/orders/1
  # DELETE /admin/history/orders/1.xml
  def destroy
    @admin_history_order = Admin::History::Order.find(params[:id])
    @admin_history_order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_history_orders_url) }
      format.xml  { head :ok }
    end
  end
end
