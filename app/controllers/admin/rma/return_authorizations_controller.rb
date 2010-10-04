class Admin::Rma::ReturnAuthorizationsController < Admin::Rma::BaseController
  # GET /return_authorizations
  # GET /return_authorizations.xml
  def index
    @return_authorizations = ReturnAuthorization.admin_grid(params)

    respond_to do |format|
      format.html
      format.json { render :json => @return_authorizations.to_jqgrid_json(
        [ :user_name, :order_number, :number, :amount, :state ],
        @return_authorizations.per_page, #params[:page],
        @return_authorizations.current_page, #params[:rows],
        @return_authorizations.total_entries)

      }
    end
  end

  # GET /return_authorizations/1
  # GET /return_authorizations/1.xml
  def show
    @return_authorization = ReturnAuthorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /return_authorizations/new
  # GET /return_authorizations/new.xml
  def new
    @return_authorization = ReturnAuthorization.new

    respond_to do |format|
      format.html # new.html.erb
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
        format.html { redirect_to(admin_rma_return_authorization_url(@return_authorization), :notice => 'Return authorization was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /return_authorizations/1
  # PUT /return_authorizations/1.xml
  def update
    @return_authorization = ReturnAuthorization.find(params[:id])

    respond_to do |format|
      if @return_authorization.update_attributes(params[:return_authorization])
        format.html { redirect_to(admin_rma_return_authorization_url(@return_authorization), :notice => 'Return authorization was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /return_authorizations/1
  # DELETE /return_authorizations/1.xml
  def destroy
    @return_authorization = ReturnAuthorization.find(params[:id])
    @return_authorization.update_attributes(:active => false)

    respond_to do |format|
      format.html { redirect_to(admin_rma_return_authorizations_url) }
    end
  end
end
