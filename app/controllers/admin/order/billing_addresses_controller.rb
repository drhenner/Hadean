class Admin::Order::BillingAddressesController < ApplicationController
  # GET /admin/order/billing_addresses
  # GET /admin/order/billing_addresses.xml
  def index
    @admin_order_billing_addresses = Admin::Order::BillingAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_order_billing_addresses }
    end
  end

  # GET /admin/order/billing_addresses/1
  # GET /admin/order/billing_addresses/1.xml
  def show
    @admin_order_billing_address = Admin::Order::BillingAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_order_billing_address }
    end
  end

  # GET /admin/order/billing_addresses/new
  # GET /admin/order/billing_addresses/new.xml
  def new
    @admin_order_billing_address = Admin::Order::BillingAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_order_billing_address }
    end
  end

  # GET /admin/order/billing_addresses/1/edit
  def edit
    @admin_order_billing_address = Admin::Order::BillingAddress.find(params[:id])
  end

  # POST /admin/order/billing_addresses
  # POST /admin/order/billing_addresses.xml
  def create
    @admin_order_billing_address = Admin::Order::BillingAddress.new(params[:admin_order_billing_address])

    respond_to do |format|
      if @admin_order_billing_address.save
        format.html { redirect_to(@admin_order_billing_address, :notice => 'Billing address was successfully created.') }
        format.xml  { render :xml => @admin_order_billing_address, :status => :created, :location => @admin_order_billing_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_billing_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/billing_addresses/1
  # PUT /admin/order/billing_addresses/1.xml
  def update
    @admin_order_billing_address = Admin::Order::BillingAddress.find(params[:id])

    respond_to do |format|
      if @admin_order_billing_address.update_attributes(params[:admin_order_billing_address])
        format.html { redirect_to(@admin_order_billing_address, :notice => 'Billing address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_billing_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/billing_addresses/1
  # DELETE /admin/order/billing_addresses/1.xml
  def destroy
    @admin_order_billing_address = Admin::Order::BillingAddress.find(params[:id])
    @admin_order_billing_address.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_billing_addresses_url) }
      format.xml  { head :ok }
    end
  end
end
