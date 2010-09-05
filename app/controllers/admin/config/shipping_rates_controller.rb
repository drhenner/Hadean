class Admin::Config::ShippingRatesController < Admin::BaseController
  # GET /shipping_rates
  # GET /shipping_rates.xml
  def index
    form_info
    if @shipping_methods.empty?
      flash[:notice] = 'You need a Shipping Method before you create a shippoing rate.'
      redirect_to admin_config_shipping_methods_path
    else
      @shipping_rates = ShippingRate.includes([:shipping_method, :shipping_rate_type]).all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @shipping_rates }
      end
    end
  end

  # GET /shipping_rates/1
  # GET /shipping_rates/1.xml
  def show
    @shipping_rate = ShippingRate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping_rate }
    end
  end

  # GET /shipping_rates/new
  # GET /shipping_rates/new.xml
  def new
    @shipping_rate = ShippingRate.new
    form_info
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_rate }
    end
  end

  # GET /shipping_rates/1/edit
  def edit
    @shipping_rate = ShippingRate.find(params[:id])
    form_info
  end

  # POST /shipping_rates
  # POST /shipping_rates.xml
  def create
    @shipping_rate = ShippingRate.new(params[:shipping_rate])

    respond_to do |format|
      if @shipping_rate.save
        format.html { redirect_to(admin_config_shipping_rate_url(@shipping_rate), :notice => 'Shipping rate was successfully created.') }
        format.xml  { render :xml => @shipping_rate, :status => :created, :location => @shipping_rate }
      else
        form_info
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shipping_rates/1
  # PUT /shipping_rates/1.xml
  def update
    @shipping_rate = ShippingRate.find(params[:id])

    respond_to do |format|
      if @shipping_rate.update_attributes(params[:shipping_rate])
        format.html { redirect_to(admin_config_shipping_rate_url(@shipping_rate), :notice => 'Shipping rate was successfully updated.') }
        format.xml  { head :ok }
      else
        form_info
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_rates/1
  # DELETE /shipping_rates/1.xml
  def destroy
    @shipping_rate = ShippingRate.find(params[:id])
    @shipping_rate.destroy

    respond_to do |format|
      format.html { redirect_to(shipping_rates_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def form_info
    @shipping_rate_types = ShippingRateType.all
    @shipping_methods = ShippingMethod.all
  end
end
