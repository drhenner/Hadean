class Admin::Order::CreditCardsController < Admin::Order::BaseController
  # GET /admin/order/credit_cards
  # GET /admin/order/credit_cards.xml
  def index
    @admin_order_credit_cards = Admin::Order::CreditCard.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_order_credit_cards }
    end
  end

  # GET /admin/order/credit_cards/1
  # GET /admin/order/credit_cards/1.xml
  def show
    @admin_order_credit_card = Admin::Order::CreditCard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_order_credit_card }
    end
  end

  # GET /admin/order/credit_cards/new
  # GET /admin/order/credit_cards/new.xml
  def new
    @admin_order_credit_card = Admin::Order::CreditCard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_order_credit_card }
    end
  end

  # GET /admin/order/credit_cards/1/edit
  def edit
    @admin_order_credit_card = Admin::Order::CreditCard.find(params[:id])
  end

  # POST /admin/order/credit_cards
  # POST /admin/order/credit_cards.xml
  def create
    @admin_order_credit_card = Admin::Order::CreditCard.new(params[:admin_order_credit_card])

    respond_to do |format|
      if @admin_order_credit_card.save
        format.html { redirect_to(@admin_order_credit_card, :notice => 'Credit card was successfully created.') }
        format.xml  { render :xml => @admin_order_credit_card, :status => :created, :location => @admin_order_credit_card }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_credit_card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/credit_cards/1
  # PUT /admin/order/credit_cards/1.xml
  def update
    @admin_order_credit_card = Admin::Order::CreditCard.find(params[:id])

    respond_to do |format|
      if @admin_order_credit_card.update_attributes(params[:admin_order_credit_card])
        format.html { redirect_to(@admin_order_credit_card, :notice => 'Credit card was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_credit_card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/credit_cards/1
  # DELETE /admin/order/credit_cards/1.xml
  def destroy
    @admin_order_credit_card = Admin::Order::CreditCard.find(params[:id])
    @admin_order_credit_card.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_credit_cards_url) }
      format.xml  { head :ok }
    end
  end
end
