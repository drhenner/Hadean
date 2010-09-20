class Admin::Order::ProductsController < ApplicationController
  # GET /admin/order/products
  # GET /admin/order/products.xml
  def index
    @admin_order_products = Admin::Order::Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_order_products }
    end
  end

  # GET /admin/order/products/1
  # GET /admin/order/products/1.xml
  def show
    @admin_order_product = Admin::Order::Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_order_product }
    end
  end

  # GET /admin/order/products/new
  # GET /admin/order/products/new.xml
  def new
    @admin_order_product = Admin::Order::Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_order_product }
    end
  end

  # GET /admin/order/products/1/edit
  def edit
    @admin_order_product = Admin::Order::Product.find(params[:id])
  end

  # POST /admin/order/products
  # POST /admin/order/products.xml
  def create
    @admin_order_product = Admin::Order::Product.new(params[:admin_order_product])

    respond_to do |format|
      if @admin_order_product.save
        format.html { redirect_to(@admin_order_product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @admin_order_product, :status => :created, :location => @admin_order_product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_order_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/order/products/1
  # PUT /admin/order/products/1.xml
  def update
    @admin_order_product = Admin::Order::Product.find(params[:id])

    respond_to do |format|
      if @admin_order_product.update_attributes(params[:admin_order_product])
        format.html { redirect_to(@admin_order_product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_order_product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/order/products/1
  # DELETE /admin/order/products/1.xml
  def destroy
    @admin_order_product = Admin::Order::Product.find(params[:id])
    @admin_order_product.destroy

    respond_to do |format|
      format.html { redirect_to(admin_order_products_url) }
      format.xml  { head :ok }
    end
  end
end
