class Admin::Config::ShippingRatesController < ApplicationController
  # GET /shipping_rates
  # GET /shipping_rates.xml
  def index
    @shipping_rates = ShippingRate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipping_rates }
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_rate }
    end
  end

  # GET /shipping_rates/1/edit
  def edit
    @shipping_rate = ShippingRate.find(params[:id])
  end

  # POST /shipping_rates
  # POST /shipping_rates.xml
  def create
    @shipping_rate = ShippingRate.new(params[:shipping_rate])

    respond_to do |format|
      if @shipping_rate.save
        format.html { redirect_to(@shipping_rate, :notice => 'Shipping rate was successfully created.') }
        format.xml  { render :xml => @shipping_rate, :status => :created, :location => @shipping_rate }
      else
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
        format.html { redirect_to(@shipping_rate, :notice => 'Shipping rate was successfully updated.') }
        format.xml  { head :ok }
      else
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
end
