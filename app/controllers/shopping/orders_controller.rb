class Shopping::OrdersController < Shopping::BaseController
  # GET /shopping/orders
  # GET /shopping/orders.xml
  ### The intent of this action is two fold
  #
  # A)  if there is a current order redirect to the process that 
  # => needs to be completed to finish the order process.
  # B)  if the order is ready to be checked out...  give the order summary page.
  #
  ##### THIS METHOD IS BASICALLY A CHECKOUT ENGINE
  def index
    #current or in-progress otherwise cart (unless cart is empty)
    @order = find_or_create_order 
    if f = next_form(@order)
      redirect_to f
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @orders }
      end
    end
  end

  # GET /shopping/orders/1
  # GET /shopping/orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /shopping/orders/new
  # GET /shopping/orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /shopping/orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /shopping/orders
  # POST /shopping/orders.xml
  def create
    @order = Order.new(params[:shopping_order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shopping/orders/1
  # PUT /shopping/orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:shopping_order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping/orders/1
  # DELETE /shopping/orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(shopping_orders_url) }
      format.xml  { head :ok }
    end
  end
end
