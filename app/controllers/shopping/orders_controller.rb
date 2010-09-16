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
      session_cart.add_items_to_checkout(@order)
      redirect_to f
    else
      @order.order_total
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

  # GET /shopping/orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /shopping/orders
  # POST /shopping/orders.xml
  def update
    @order = find_or_create_order
    #@invoice = Invoice.new(params[:order])
    @order.ip_address = request.remote_ip
    if @order.create_invoice(credit_card, :amount => @order.find_total)
      if @order.purchase
        render :action => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'index'
    end
  end


end
