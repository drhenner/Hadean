class Admin::Order::ShippingAddressesController < Admin::Order::BaseController
  # GET /admin/order/shipping_addresses
  # GET /admin/order/shipping_addresses.xml
  def index
    @shipping_addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipping_addresses }
    end
  end

  # GET /admin/order/shipping_addresses/new
  # GET /admin/order/shipping_addresses/new.xml
  def new
    @shipping_address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_address }
    end
  end

  # POST /admin/order/shipping_addresses
  # POST /admin/order/shipping_addresses.xml
  def create
    @shipping_address = Address.new(params[:admin_order_shipping_address])

    respond_to do |format|
      if @shipping_address.save
        format.html { redirect_to(@shipping_address, :notice => 'Shipping address was successfully created.') }
        format.xml  { render :xml => @shipping_address, :status => :created, :location => @shipping_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/shipping_addresses/1
  # PUT /admin/order/shipping_addresses/1.xml
  def update
    @shipping_address = Address.find(params[:id])

    respond_to do |format|
      if @shipping_address.update_attributes(params[:admin_order_shipping_address])
        format.html { redirect_to(@shipping_address, :notice => 'Shipping address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

end
