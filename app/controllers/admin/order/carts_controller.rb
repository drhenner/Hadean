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
    @cart = Cart.find(params[:id])

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
    @cart         =  session_admin_cart
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(cc_params)
    
    if @credit_card.valid?
      Order.transaction do
        @order = Order.new_admin_cart(@cart)
        @order.ip_address = request.remote_ip
        response = @order.create_invoice_transaction( @credit_card, 
                                          @order.find_total, 
                                          { :email            => @order.email, 
                                            :billing_address  => @cart[:billing_address], 
                                            :ip               => @order.ip_address })
      end
      debugger
      if response
        if response.success?
          render :action => "success"
        else
          render :action => "failure"
        end
      else
        render :action => 'index' #admin_order_carts_url
      end
    else
      flash[:error] = "Credit Card is not valid."
      render :action => 'index'
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
    session_admin_cart = nil

    respond_to do |format|
      format.html { redirect_to(admin_order_carts_url) }
    end
  end
  
  
  private
  
  def cc_params
    {
          :type               => params[:type],
          :number             => params[:number],
          :verification_value => params[:verification_value],
          :month              => params[:month],
          :year               => params[:year],
          :first_name         => params[:first_name],
          :last_name          => params[:last_name]
    }
  end
end
