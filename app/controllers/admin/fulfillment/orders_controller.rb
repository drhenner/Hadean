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
      format.xml  { render :xml => @order }
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
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/fulfillment/orders/1
  # PUT /admin/fulfillment/orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(admin_fulfillment_orders_path(@order), :notice => 'Order was successfully updated.') }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

end
