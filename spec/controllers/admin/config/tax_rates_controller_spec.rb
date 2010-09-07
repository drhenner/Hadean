require 'spec_helper'

describe Admin::Config::TaxRatesController do

  def mock_tax_rate(stubs={})
    @mock_tax_rate ||= mock_model(TaxRate, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tax_rates as @tax_rates" do
      TaxRate.stub(:all) { [mock_tax_rate] }
      get :index
      assigns(:tax_rates).should eq([mock_tax_rate])
    end
  end

  describe "GET show" do
    it "assigns the requested tax_rate as @tax_rate" do
      TaxRate.stub(:find).with("37") { mock_tax_rate }
      get :show, :id => "37"
      assigns(:tax_rate).should be(mock_tax_rate)
    end
  end

  describe "GET new" do
    it "assigns a new tax_rate as @tax_rate" do
      TaxRate.stub(:new) { mock_tax_rate }
      get :new
      assigns(:tax_rate).should be(mock_tax_rate)
    end
  end

  describe "GET edit" do
    it "assigns the requested tax_rate as @tax_rate" do
      TaxRate.stub(:find).with("37") { mock_tax_rate }
      get :edit, :id => "37"
      assigns(:tax_rate).should be(mock_tax_rate)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created tax_rate as @tax_rate" do
        TaxRate.stub(:new).with({'these' => 'params'}) { mock_tax_rate(:save => true) }
        post :create, :tax_rate => {'these' => 'params'}
        assigns(:tax_rate).should be(mock_tax_rate)
      end

      it "redirects to the created tax_rate" do
        TaxRate.stub(:new) { mock_tax_rate(:save => true) }
        post :create, :tax_rate => {}
        response.should redirect_to(tax_rate_url(mock_tax_rate))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tax_rate as @tax_rate" do
        TaxRate.stub(:new).with({'these' => 'params'}) { mock_tax_rate(:save => false) }
        post :create, :tax_rate => {'these' => 'params'}
        assigns(:tax_rate).should be(mock_tax_rate)
      end

      it "re-renders the 'new' template" do
        TaxRate.stub(:new) { mock_tax_rate(:save => false) }
        post :create, :tax_rate => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested tax_rate" do
        TaxRate.should_receive(:find).with("37") { mock_tax_rate }
        mock_tax_rate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tax_rate => {'these' => 'params'}
      end

      it "assigns the requested tax_rate as @tax_rate" do
        TaxRate.stub(:find) { mock_tax_rate(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tax_rate).should be(mock_tax_rate)
      end

      it "redirects to the tax_rate" do
        TaxRate.stub(:find) { mock_tax_rate(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tax_rate_url(mock_tax_rate))
      end
    end

    describe "with invalid params" do
      it "assigns the tax_rate as @tax_rate" do
        TaxRate.stub(:find) { mock_tax_rate(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tax_rate).should be(mock_tax_rate)
      end

      it "re-renders the 'edit' template" do
        TaxRate.stub(:find) { mock_tax_rate(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested tax_rate" do
      TaxRate.should_receive(:find).with("37") { mock_tax_rate }
      mock_tax_rate.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tax_rates list" do
      TaxRate.stub(:find) { mock_tax_rate }
      delete :destroy, :id => "1"
      response.should redirect_to(tax_rates_url)
    end
  end

end
