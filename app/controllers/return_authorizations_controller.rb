class ReturnAuthorizationsController < ApplicationController
  # GET /return_authorizations
  # GET /return_authorizations.xml
  def index
    @return_authorizations = ReturnAuthorization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @return_authorizations }
    end
  end

  # GET /return_authorizations/1
  # GET /return_authorizations/1.xml
  def show
    @return_authorization = ReturnAuthorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @return_authorization }
    end
  end

  # GET /return_authorizations/new
  # GET /return_authorizations/new.xml
  def new
    @return_authorization = ReturnAuthorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @return_authorization }
    end
  end

  # GET /return_authorizations/1/edit
  def edit
    @return_authorization = ReturnAuthorization.find(params[:id])
  end

  # POST /return_authorizations
  # POST /return_authorizations.xml
  def create
    @return_authorization = ReturnAuthorization.new(params[:return_authorization])

    respond_to do |format|
      if @return_authorization.save
        format.html { redirect_to(@return_authorization, :notice => 'Return authorization was successfully created.') }
        format.xml  { render :xml => @return_authorization, :status => :created, :location => @return_authorization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @return_authorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /return_authorizations/1
  # PUT /return_authorizations/1.xml
  def update
    @return_authorization = ReturnAuthorization.find(params[:id])

    respond_to do |format|
      if @return_authorization.update_attributes(params[:return_authorization])
        format.html { redirect_to(@return_authorization, :notice => 'Return authorization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @return_authorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /return_authorizations/1
  # DELETE /return_authorizations/1.xml
  def destroy
    @return_authorization = ReturnAuthorization.find(params[:id])
    @return_authorization.destroy

    respond_to do |format|
      format.html { redirect_to(return_authorizations_url) }
      format.xml  { head :ok }
    end
  end
end
