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
  def create
    @order = find_or_create_order
    @invoice = Invoice.new(params[:shopping_order])
@order.ip_address = request.remote_ip
if @order.create_invoice(:amount => @order.amount)
  if @order.purchase
    render :action => "success"
  else
    render :action => "failure"
  end
else
  render :action => 'new'
end

#  t.integer :order_id,  :null => false
#  t.string :number,     :null => false
#  t.decimal :amount,      :precision => 8, :scale => 2,  :null => false
#  #t.boolean :settled,     :default => false,  :null => false
#  t.string  :state,  :null => false
#  t.boolean :active,      :default => true,   :null => false



    respond_to do |format|
      if @invoice.save
        format.html { redirect_to(@invoice, :notice => 'Order was successfully created.') }
      else
        format.html { render :action => "index" }
      end
    end
  end

  # PUT /shopping/orders/1
  # PUT /shopping/orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:shopping_order])
        format.html { redirect_to(shopping_orders_path, :notice => 'Order was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
