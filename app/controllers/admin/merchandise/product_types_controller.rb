class Admin::Merchandise::ProductTypesController < ApplicationController
  
  def index
    @product_types = ProductType.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @product_types.to_jqgrid_json(
        [ :name ],
        @product_types.per_page, #params[:page],
        @product_types.current_page, #params[:rows],
        @product_types.total_entries)
        
      }
    end
  end
  
  def show
    @product_type = ProductType.find(params[:id])
    respond_with(@product_type)
  end
  
  def new
    @product_type = ProductType.new
  end
  
  def create
    @product_type = ProductType.new(params[:product_type])
    
    if @product_type.save
      redirect_to :action => :index
    else
      flash[:error] = "The product_type could not be saved"
      render :action => :new
    end
  end
  
  def edit
    @product_type = ProductType.find(params[:id])
  end
  
  def update
    @product_type = ProductType.find(params[:id])
    
    if @product_type.update_attributes(params[:product_type])
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    @product_type = ProductType.find(params[:id])
    @product_type.active = false
    @product_type.save
    
    redirect_to :action => :index
  end
  
end
