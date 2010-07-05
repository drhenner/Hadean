class Admin::Merchandise::PropertiesController < ApplicationController
  
  def index
    @properties = Property.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @properties.to_jqgrid_json(
        [ :name ],
        params[:page],
        params[:rows],
        @properties.total_entries,
        {})
      }
    end
  end
  
  def show
    @property = Property.find(params[:id])
  end
  
  def new
    @property = Property.new
  end
  
  def create
    @property = Property.new(params[:property])
    
    if @property.save
      render :action => :show
    else
      flash[:error] = "The property could not be saved"
      render :action => :new
    end
  end
  
  def edit
    @property = Property.find(params[:id])
  end
  
  def update
    @property = Property.find(params[:id])
    
    if @property.update_attributes(params[:property])
      render :action => :show
    else
      render :action => :edit
    end
  end
  
  def destroy
    @property = Property.find(params[:id])
    @property.active = false
    @property.save
    
    redirect_to :action => :index
  end

end
