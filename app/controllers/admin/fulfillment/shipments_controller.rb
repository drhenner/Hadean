class Admin::Fulfillment::ShipmentsController < Admin::Fulfillment::BaseController
  # GET /admin/fulfillment/shipments
  # GET /admin/fulfillment/shipments.xml
  def index
    load_info
    @shipments = @order.shipments.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/fulfillment/shipments/1
  # GET /admin/fulfillment/shipments/1.xml
  def show
    load_info
    @shipment = @order.shipments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /admin/fulfillment/shipments/new
  # GET /admin/fulfillment/shipments/new.xml
  def new
    load_info
    @shipment = @order.shipments.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/fulfillment/shipments/1/edit
  def edit
    load_info
    @shipment = @order.shipments.find(params[:id])
  end

  # POST /admin/fulfillment/shipments
  # POST /admin/fulfillment/shipments.xml
  def create
    load_info
    @shipment = @order.shipments.new(params[:shipment])

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to(admin_fulfillment_shipment_path(@shipment), :notice => 'Shipment was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/fulfillment/shipments/1
  # PUT /admin/fulfillment/shipments/1.xml
  def update
    load_info
    @shipment = Shipment.find(params[:id])

    respond_to do |format|
      if @shipment.update_attributes(params[:shipment])
        format.html { redirect_to(admin_fulfillment_shipment_path(@shipment), :notice => 'Shipment was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/fulfillment/shipments/1
  # DELETE /admin/fulfillment/shipments/1.xml
  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.update_attributes(:active => false)

    respond_to do |format|
      format.html { redirect_to(admin_fulfillment_shipments_url) }
    end
  end
  
  private
  
  def load_info
    @order = Order.includes([:shipments, {:order_items => [:shipment, :variant]}])
  end
  
  def form_info
    
  end
  
end
