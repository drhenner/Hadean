class Admin::Merchandise::ProductsController < Admin::BaseController
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
    form_info
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
      form_info
      flash[:error] = "The product could not be saved"
      render :action => :new
    end
  end
  
  def edit
    @product        = Product.includes(:properties,:product_properties, {:prototype => :properties}).find(params[:id])
    form_info
  end
  
  def update
    @product = Product.find(params[:id])
    
    if @product.update_attributes(params[:product])
      redirect_to :action => :index
    else
      form_info
      render :action => :edit
    end
  end
  
  def add_properties
    prototype  = Prototype.includes(:properties).find(params[:id])
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
  
  private
  
    def form_info
      @prototypes = Prototype.all.collect{|pt| [pt.name, pt.id]}
      @all_properties = Property.all
      @select_product_types = ProductType.all.collect{|pt| [pt.name, pt.id]}
      @select_shipping_category = ShippingCategory.all.collect {|sc| [sc.name, sc.id]}
    end
  
end
