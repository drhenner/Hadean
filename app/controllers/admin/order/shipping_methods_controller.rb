class Admin::Order::ShippingMethodsController < Admin::Order::BaseController
  # GET /admin/order/shipping_methods
  # GET /admin/order/shipping_methods.xml
  def index
    @shipping_methods = #session_admin_cart[:user].shipping_addresses

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/order/shipping_methods/1
  # GET /admin/order/shipping_methods/1.xml
  def show
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/order/shipping_methods/new
  # GET /admin/order/shipping_methods/new.xml
  def new
    @shipping_method = ShippingMethod.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/order/shipping_methods/1/edit
  def edit
    @admin_order_shipping_method = Admin::Order::ShippingMethod.find(params[:id])
  end

  # POST /admin/order/shipping_methods
  # POST /admin/order/shipping_methods.xml
  def create
    @admin_order_shipping_method = Admin::Order::ShippingMethod.new(params[:admin_order_shipping_method])

    respond_to do |format|
      if @admin_order_shipping_method.save
        format.html { redirect_to(@admin_order_shipping_method, :notice => 'Shipping method was successfully created.') }
        format.xml  { render :xml => @admin_order_shipping_method, :status => :created, :location => @admin_order_shipping_method }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_shipping_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/shipping_methods/1
  # PUT /admin/order/shipping_methods/1.xml
  def update
    @admin_order_shipping_method = Admin::Order::ShippingMethod.find(params[:id])

    respond_to do |format|
      if @admin_order_shipping_method.update_attributes(params[:admin_order_shipping_method])
        format.html { redirect_to(@admin_order_shipping_method, :notice => 'Shipping method was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_shipping_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/shipping_methods/1
  # DELETE /admin/order/shipping_methods/1.xml
  def destroy
    @admin_order_shipping_method = Admin::Order::ShippingMethod.find(params[:id])
    @admin_order_shipping_method.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_shipping_methods_url) }
      format.xml  { head :ok }
    end
  end
end
