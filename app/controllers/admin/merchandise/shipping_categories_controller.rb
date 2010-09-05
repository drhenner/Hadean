class Admin::Merchandise::ShippingCategoriesController < ApplicationController
  # GET /admin/merchandise/shipping_categories
  # GET /admin/merchandise/shipping_categories.xml
  def index
    @admin_merchandise_shipping_categories = Admin::Merchandise::ShippingCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_merchandise_shipping_categories }
    end
  end

  # GET /admin/merchandise/shipping_categories/1
  # GET /admin/merchandise/shipping_categories/1.xml
  def show
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_merchandise_shipping_category }
    end
  end

  # GET /admin/merchandise/shipping_categories/new
  # GET /admin/merchandise/shipping_categories/new.xml
  def new
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_merchandise_shipping_category }
    end
  end

  # GET /admin/merchandise/shipping_categories/1/edit
  def edit
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.find(params[:id])
  end

  # POST /admin/merchandise/shipping_categories
  # POST /admin/merchandise/shipping_categories.xml
  def create
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.new(params[:admin_merchandise_shipping_category])

    respond_to do |format|
      if @admin_merchandise_shipping_category.save
        format.html { redirect_to(@admin_merchandise_shipping_category, :notice => 'Shipping category was successfully created.') }
        format.xml  { render :xml => @admin_merchandise_shipping_category, :status => :created, :location => @admin_merchandise_shipping_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_merchandise_shipping_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/merchandise/shipping_categories/1
  # PUT /admin/merchandise/shipping_categories/1.xml
  def update
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.find(params[:id])

    respond_to do |format|
      if @admin_merchandise_shipping_category.update_attributes(params[:admin_merchandise_shipping_category])
        format.html { redirect_to(@admin_merchandise_shipping_category, :notice => 'Shipping category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_merchandise_shipping_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/merchandise/shipping_categories/1
  # DELETE /admin/merchandise/shipping_categories/1.xml
  def destroy
    @admin_merchandise_shipping_category = Admin::Merchandise::ShippingCategory.find(params[:id])
    @admin_merchandise_shipping_category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_merchandise_shipping_categories_url) }
      format.xml  { head :ok }
    end
  end
end
