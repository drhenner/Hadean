class Admin::Merchandise::ProductsController < ApplicationController
  respond_to :html, :json
  def index
    @products = Product.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @products.to_jqgrid_json(
        [ :name, :display_active ],
        @products.per_page, #params[:page],
        @products.current_page, #params[:rows],
        @products.total_entries)
        
      }
    end
  end
  
  def show
    @product = Product.find(params[:id])
    respond_with(@product)
  end
  
  def new
    @all_properties = Property.all
    @prototypes = Prototype.all
    if @prototypes.empty?
      flash[:notice] = "You must create a prototype before you create a product."
      redirect_to new_admin_merchandise_prototype_path
    else
      @product            = Product.new
      @product.prototype  = Prototype.new
    end
  end
  
  def create
    @product = Product.new(params[:product])
    
    if @product.save
      redirect_to :action => :index
    else
      @prototypes = Prototype.all
      @all_properties = Property.all
      flash[:error] = "The product could not be saved"
      render :action => :new
    end
  end
  
  def edit
    @product        = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:id])
    @prototypes     = Prototype.all
    @all_properties = Property.all
  end
  
  def update
    @product = Product.find(params[:id])
    
    if @product.update_attributes(params[:product])
      redirect_to :action => :index
    else
      @all_properties = Property.all
      render :action => :edit
    end
  end
  
  def add_properties
    prototype  = Prototype.includes(:properties).find(params[:id])
    #@product    =   Product.includes(:properties).find(params[:product_id]) if params[:product_id]
    @properties = prototype.properties
    all_properties = Property.all
    
    @properties_hash = all_properties.inject({:active => [], :inactive => []}) do |h, property|
      if  @properties.detect{|p| (p.id == property.id) }
        h[:active] << property.id
      else
        h[:inactive] << property.id
      end
      h
    end
    #render :template => 'admin/merchandise/products/add_properties', :layout => false
    respond_to do |format|
      format.html
      format.json { render :json => @properties_hash.to_json }
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.active = false
    @product.save
    
    redirect_to :action => :index
  end
  
end
