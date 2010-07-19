class Admin::Merchandise::PrototypesController < ApplicationController
  respond_to :html, :json
  def index
    @prototypes = Prototype.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @prototypes.to_jqgrid_json(
        [ :display_name, :display_active ],
        @prototypes.per_page, #params[:page],
        @prototypes.current_page, #params[:rows],
        @prototypes.total_entries)
      
      }
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    respond_with(@prototype)
  end

  def new
    @all_properties = Property.all
    @prototype      = Prototype.new
    @prototype.properties.new# << Property.new
  end

  def create
    @prototype = Prototype.new(params[:prototype])
  
    if @prototype.save
      redirect_to :action => :index
    else
      @properties = Property.all
      flash[:error] = "The prototype property could not be saved"
      render :action => :new
    end
  end

  def edit
    @properties = Property.all
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = PrototypeProperty.find(params[:id])
  
    if @prototype.update_attributes(params[:prototype])
      redirect_to :action => :index
    else
      @properties = Property.all
      render :action => :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.active = false
    @prototype.save
  
    redirect_to :action => :index
  end
end
