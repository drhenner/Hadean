class Shopping::ShippingMethodsController < Shopping::BaseController
  # GET /shopping/shipping_methods
  # GET /shopping/shipping_methods.xml
  def index
    unless find_or_create_order.ship_address_id
      flash[:notice] = 'Select an address before you select a shipping method.'
      redirect_to shopping_addresses_url
    else
      @shipping_methods = find_or_create_order.ship_address.state.shipping_zone.shipping_methods

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @shipping_methods }
      end
    end
  end

  # GET /shopping/shipping_methods/1
  # GET /shopping/shipping_methods/1.xml
  def show
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping_method }
    end
  end

  # GET /shopping/shipping_methods/1/edit
  def edit
    @shipping_method = ShippingMethod.find(params[:id])
  end

  # POST /shopping/shipping_methods
  # POST /shopping/shipping_methods.xml
  def create
    @shipping_method = ShippingMethod.new(params[:shopping_shipping_method])

    respond_to do |format|
      if @shipping_method.save
        format.html { redirect_to(@shipping_method, :notice => 'Shipping method was successfully created.') }
        format.xml  { render :xml => @shipping_method, :status => :created, :location => @shipping_method }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shopping/shipping_methods/1
  # PUT /shopping/shipping_methods/1.xml
  def update
    @shipping_method = ShippingMethod.find(params[:id])

    respond_to do |format|
      if @shipping_method.update_attributes(params[:shopping_shipping_method])
        format.html { redirect_to(@shipping_method, :notice => 'Shipping method was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_method.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping/shipping_methods/1
  # DELETE /shopping/shipping_methods/1.xml
  def destroy
    @shipping_method = ShippingMethod.find(params[:id])
    @shipping_method.destroy

    respond_to do |format|
      format.html { redirect_to(shopping_shipping_methods_url) }
      format.xml  { head :ok }
    end
  end
end
