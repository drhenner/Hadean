class Admin::Merchandise::PrototypePropertiesController < ApplicationController
  
  respond_to :html, :json
  def index
    @prototype_properties = PrototypeProperty.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @prototype_properties.to_jqgrid_json(
        [ :display_name, :display_active ],
        @prototype_properties.per_page, #params[:page],
        @prototype_properties.current_page, #params[:rows],
        @prototype_properties.total_entries)
        
      }
    end
  end
  
  def show
    @prototype_property = PrototypeProperty.find(params[:id])
    respond_with(@prototype_property)
  end
  
  def new
    @prototype_property = PrototypeProperty.new
  end
  
  def create
    @prototype_property = PrototypeProperty.new(params[:prototype_property])
    
    if @prototype_property.save
      redirect_to :action => :index
    else
      flash[:error] = "The prototype property could not be saved"
      render :action => :new
    end
  end
  
  def edit
    @prototype_property = PrototypeProperty.find(params[:id])
  end
  
  def update
    @prototype_property = PrototypeProperty.find(params[:id])
    
    if @prototype_property.update_attributes(params[:prototype_property])
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    @prototype_property = PrototypeProperty.find(params[:id])
    @prototype_property.active = false
    @prototype_property.save
    
    redirect_to :action => :index
  end
end
