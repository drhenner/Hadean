class Admin::Order::CartsController < Admin::Order::BaseController
  # GET /admin/order/carts
  # GET /admin/order/carts.xml
  def index
    authorize! :create_orders, current_user
    if f = next_admin_cart_form
      redirect_to f
    else
      @cart = session_admin_cart 
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new()
      #@order.order_total
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end

  # GET /admin/order/carts/1
  # GET /admin/order/carts/1.xml
  def show
    @admin_order_cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_order_cart }
    end
  end

  # GET /admin/order/carts/new
  # GET /admin/order/carts/new.xml
  def new
    @admin_order_cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_order_cart }
    end
  end

  # GET /admin/order/carts/1/edit
  def edit
    @admin_order_cart = Cart.find(params[:id])
  end

  # POST /admin/order/carts
  # POST /admin/order/carts.xml
  def create
    @admin_order_cart = Cart.new(params[:admin_order_cart])

    respond_to do |format|
      if @admin_order_cart.save
        format.html { redirect_to(@admin_order_cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @admin_order_cart, :status => :created, :location => @admin_order_cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/carts/1
  # PUT /admin/order/carts/1.xml
  def update
    @admin_order_cart = Admin::Order::Cart.find(params[:id])

    respond_to do |format|
      if @admin_order_cart.update_attributes(params[:admin_order_cart])
        format.html { redirect_to(@admin_order_cart, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/carts/1
  # DELETE /admin/order/carts/1.xml
  def destroy
    @admin_order_cart = Admin::Order::Cart.find(params[:id])
    @admin_order_cart.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_carts_url) }
      format.xml  { head :ok }
    end
  end
end
