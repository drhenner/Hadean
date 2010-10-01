class Admin::Fulfillment::OrdersController < Admin::Fulfillment::BaseController
  # GET /admin/fulfillment/orders
  # GET /admin/fulfillment/orders.xml
  def index
    @orders = Order.fulfillment_grid(params)

    respond_to do |format|
      format.html # index.html.erb
      
      format.json { render :json => @orders.to_jqgrid_json(
        [ :display_completed_at, :email, :number, :name ],
        @orders.per_page,
        @orders.current_page, 
        @orders.total_entries)

      }
    end
  end

  # GET /admin/fulfillment/orders/1
  # GET /admin/fulfillment/orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /admin/fulfillment/orders/new
  # GET /admin/fulfillment/orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/fulfillment/orders/1/edit
  def edit
    @order = Order.includes([:shipments, {:order_items => [:shipment, :variant]}]).find(params[:id])
  end

  # POST /admin/fulfillment/orders
  # POST /admin/fulfillment/orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(admin_fulfillment_orders_path(@order), :notice => 'Order was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/fulfillment/orders/1
  # PUT /admin/fulfillment/orders/1.xml
  def update
    @order = Order.find(params[:id])

##  several things happen on this request
# => Payment is captured
# => Invoice is updated to log leger transactions
# => Shipment is marked as ready to send and associated to the order_items
# => If everything works send the user to the shipment page


## TODO 
# => Allow partial payments
# => mark only order_items that will be shipped

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(admin_fulfillment_orders_path(@order), :notice => 'Order was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/fulfillment/shipments/1
  # DELETE /admin/fulfillment/shipments/1.xml
  def destroy
    raise error
    @order    = Order.find(params[:id])
    @order.update_attributes(:active => false)
    @shipment = Shipment.find(params[:id])
    @shipment.update_attributes(:active => false)

    respond_to do |format|
      format.html { redirect_to(admin_fulfillment_shipments_url) }
    end
  end

end
