class Shopping::CartItemsController < ApplicationController

  # GET /carts
  # GET /carts.xml
  def index
    @cart_items = session_cart.shopping_cart_items

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cart_items }
    end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    @cart_item = session_cart.shopping_cart_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart_item = CartItem.new(:user_id => current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart_item = session_cart.shopping_cart_items.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart_item = new_cart_item
    
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to(@cart_item, :notice => 'Item was successfully added to the cart.') }
        format.xml  { render :xml => @cart_item, :status => :created, :location => @cart_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart_item = session_cart.shopping_cart_items.find(params[:id])

    respond_to do |format|
      if @cart_item.update_attributes(params[:cart])
        format.html { redirect_to(@cart_item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.active = false
    @cart_item.save
    
    respond_to do |format|
      format.html { redirect_to(shopping_carts_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_new_cart_item
    if current_user
      session_cart.cart_items.new(params[:cart].merge({:user_id => current_user.id}))
    else
      ###  ADD to session cart
      session_cart.cart_items.new(params[:cart])
    end
  end
  
end
