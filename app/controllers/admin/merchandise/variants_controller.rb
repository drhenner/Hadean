class Admin::Merchandise::VariantsController < ApplicationController
  
  respond_to :html, :json
  def index
    @product = Product.find(params[:product_id])
    @variants = @product.variants.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @variants.to_jqgrid_json(
        [ :product_name, :sku, :price ],
        @variants.per_page, #params[:page],
        @variants.current_page, #params[:rows],
        @variants.total_entries)
      
      }
    end
  end

  def show
    @variant = Variant.includes(:product).find(params[:id])
    @product  =  @variant.product
    respond_with(@variant)
  end

  def new
    form_info
    @variant = Variant.new(:product_id => params[:product_id])
    @product  =  @variant.product
  end

  def create
    @variant = Variant.new(params[:variant])
  
    if @variant.save
      redirect_to :action => :index
    else
      @product  =  @variant.product
      form_info
      flash[:error] = "The variant could not be saved"
      render :action => :new
    end
  end

  def edit
    @variant  = Variant.includes(:properties,:variant_properties, {:product => :properties}).find(params[:id])
    @product  =  @variant.product
    form_info
  end

  def update
    @variant = Variant.find(params[:id])
  
    if @variant.update_attributes(params[:variant])
      redirect_to :action => :index
    else
      form_info
      @product  =  @variant.product
      render :action => :edit
    end
  end
=begin
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
=end
  def destroy
    @variant = Variant.find(params[:id])
    @variant.active = false
    @variant.save
  
    redirect_to :action => :index
  end

  private

    def form_info
      #@prototypes = Prototype.all.collect{|pt| [pt.name, pt.id]}
      #@all_properties = Property.all
      #@select_variant_types = VariantType.all.collect{|pt| [pt.name, pt.id]}
      #@select_shipping_category = ShippingCategory.all.collect {|sc| [sc.name, sc.id]}
    end
end
