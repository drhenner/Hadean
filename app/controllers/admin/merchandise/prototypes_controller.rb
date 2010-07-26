class Admin::Merchandise::PrototypesController < ApplicationController
  respond_to :html, :json
  def index
    @prototypes = Prototype.admin_grid(params)
    respond_to do |format|
      format.html
      format.json { render :json => @prototypes.to_jqgrid_json(
        [ :id, :name, :display_active ],
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

    @prototype      = Prototype.new(:active => true)
    @prototype.properties.build
  end

  def create
    @prototype = Prototype.new(params[:prototype])
  
    if @prototype.save
      redirect_to :action => :index
    else
      @all_properties = Property.all
      flash[:error] = "The prototype property could not be saved"
      render :action => :new
    end
  end

  def edit
    #@all_properties = [Property.new]
    @all_properties = Property.all#.inject(@all_properties) {|i, prop| i << prop }
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
  
    if @prototype.update_attributes(params[:prototype])
      redirect_to :action => :index
    else
      @all_properties = Property.all
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
