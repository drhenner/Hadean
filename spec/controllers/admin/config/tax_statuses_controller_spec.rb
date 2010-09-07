require 'spec_helper'

describe Admin::Config::TaxStatusesController do

  def mock_tax_status(stubs={})
    @mock_tax_status ||= mock_model(TaxStatus, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tax_statuses as @tax_statuses" do
      TaxStatus.stub(:all) { [mock_tax_status] }
      get :index
      assigns(:tax_statuses).should eq([mock_tax_status])
    end
  end

  describe "GET show" do
    it "assigns the requested tax_status as @tax_status" do
      TaxStatus.stub(:find).with("37") { mock_tax_status }
      get :show, :id => "37"
      assigns(:tax_status).should be(mock_tax_status)
    end
  end

  describe "GET new" do
    it "assigns a new tax_status as @tax_status" do
      TaxStatus.stub(:new) { mock_tax_status }
      get :new
      assigns(:tax_status).should be(mock_tax_status)
    end
  end

  describe "GET edit" do
    it "assigns the requested tax_status as @tax_status" do
      TaxStatus.stub(:find).with("37") { mock_tax_status }
      get :edit, :id => "37"
      assigns(:tax_status).should be(mock_tax_status)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created tax_status as @tax_status" do
        TaxStatus.stub(:new).with({'these' => 'params'}) { mock_tax_status(:save => true) }
        post :create, :tax_status => {'these' => 'params'}
        assigns(:tax_status).should be(mock_tax_status)
      end

      it "redirects to the created tax_status" do
        TaxStatus.stub(:new) { mock_tax_status(:save => true) }
        post :create, :tax_status => {}
        response.should redirect_to(tax_status_url(mock_tax_status))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tax_status as @tax_status" do
        TaxStatus.stub(:new).with({'these' => 'params'}) { mock_tax_status(:save => false) }
        post :create, :tax_status => {'these' => 'params'}
        assigns(:tax_status).should be(mock_tax_status)
      end

      it "re-renders the 'new' template" do
        TaxStatus.stub(:new) { mock_tax_status(:save => false) }
        post :create, :tax_status => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested tax_status" do
        TaxStatus.should_receive(:find).with("37") { mock_tax_status }
        mock_tax_status.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tax_status => {'these' => 'params'}
      end

      it "assigns the requested tax_status as @tax_status" do
        TaxStatus.stub(:find) { mock_tax_status(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tax_status).should be(mock_tax_status)
      end

      it "redirects to the tax_status" do
        TaxStatus.stub(:find) { mock_tax_status(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tax_status_url(mock_tax_status))
      end
    end

    describe "with invalid params" do
      it "assigns the tax_status as @tax_status" do
        TaxStatus.stub(:find) { mock_tax_status(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tax_status).should be(mock_tax_status)
      end

      it "re-renders the 'edit' template" do
        TaxStatus.stub(:find) { mock_tax_status(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested tax_status" do
      TaxStatus.should_receive(:find).with("37") { mock_tax_status }
      mock_tax_status.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tax_statuses list" do
      TaxStatus.stub(:find) { mock_tax_status }
      delete :destroy, :id => "1"
      response.should redirect_to(tax_statuses_url)
    end
  end

end
