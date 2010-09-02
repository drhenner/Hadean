class Shopping::AddressesController < Shopping::BaseController
  # GET /shopping/addresses
  # GET /shopping/addresses.xml
  def index
    @shopping_addresses = current_user.shipping_addresses.all
    @shopping_address = Address.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shopping_addresses }
    end
  end

  # GET /shopping/addresses/1
  # GET /shopping/addresses/1.xml
  def show
    @shopping_address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shopping_address }
    end
  end

  # GET /shopping/addresses/new
  # GET /shopping/addresses/new.xml
  def new
    @shopping_address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shopping_address }
    end
  end

  # GET /shopping/addresses/1/edit
  def edit
    @shopping_address = Address.find(params[:id])
  end

  # POST /shopping/addresses
  # POST /shopping/addresses.xml
  def create
    @shopping_address = Address.new(params[:shopping_address])

    respond_to do |format|
      if @shopping_address.save
        format.html { redirect_to(@shopping_address, :notice => 'Address was successfully created.') }
        format.xml  { render :xml => @shopping_address, :status => :created, :location => @shopping_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shopping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shopping/addresses/1
  # PUT /shopping/addresses/1.xml
  def update
    @shopping_address = Address.find(params[:id])

    respond_to do |format|
      if @shopping_address.update_attributes(params[:shopping_address])
        format.html { redirect_to(@shopping_address, :notice => 'Address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shopping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping/addresses/1
  # DELETE /shopping/addresses/1.xml
  def destroy
    @shopping_address = Address.find(params[:id])
    @shopping_address.destroy

    respond_to do |format|
      format.html { redirect_to(shopping_addresses_url) }
      format.xml  { head :ok }
    end
  end
end
