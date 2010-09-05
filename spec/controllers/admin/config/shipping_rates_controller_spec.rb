require 'spec_helper'

describe Admin::Config::ShippingRatesController do

  def mock_shipping_rate(stubs={})
    @mock_shipping_rate ||= mock_model(ShippingRate, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all shipping_rates as @shipping_rates" do
      ShippingRate.stub(:all) { [mock_shipping_rate] }
      get :index
      assigns(:shipping_rates).should eq([mock_shipping_rate])
    end
  end

  describe "GET show" do
    it "assigns the requested shipping_rate as @shipping_rate" do
      ShippingRate.stub(:find).with("37") { mock_shipping_rate }
      get :show, :id => "37"
      assigns(:shipping_rate).should be(mock_shipping_rate)
    end
  end

  describe "GET new" do
    it "assigns a new shipping_rate as @shipping_rate" do
      ShippingRate.stub(:new) { mock_shipping_rate }
      get :new
      assigns(:shipping_rate).should be(mock_shipping_rate)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipping_rate as @shipping_rate" do
      ShippingRate.stub(:find).with("37") { mock_shipping_rate }
      get :edit, :id => "37"
      assigns(:shipping_rate).should be(mock_shipping_rate)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created shipping_rate as @shipping_rate" do
        ShippingRate.stub(:new).with({'these' => 'params'}) { mock_shipping_rate(:save => true) }
        post :create, :shipping_rate => {'these' => 'params'}
        assigns(:shipping_rate).should be(mock_shipping_rate)
      end

      it "redirects to the created shipping_rate" do
        ShippingRate.stub(:new) { mock_shipping_rate(:save => true) }
        post :create, :shipping_rate => {}
        response.should redirect_to(shipping_rate_url(mock_shipping_rate))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipping_rate as @shipping_rate" do
        ShippingRate.stub(:new).with({'these' => 'params'}) { mock_shipping_rate(:save => false) }
        post :create, :shipping_rate => {'these' => 'params'}
        assigns(:shipping_rate).should be(mock_shipping_rate)
      end

      it "re-renders the 'new' template" do
        ShippingRate.stub(:new) { mock_shipping_rate(:save => false) }
        post :create, :shipping_rate => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested shipping_rate" do
        ShippingRate.should_receive(:find).with("37") { mock_shipping_rate }
        mock_shipping_rate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :shipping_rate => {'these' => 'params'}
      end

      it "assigns the requested shipping_rate as @shipping_rate" do
        ShippingRate.stub(:find) { mock_shipping_rate(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:shipping_rate).should be(mock_shipping_rate)
      end

      it "redirects to the shipping_rate" do
        ShippingRate.stub(:find) { mock_shipping_rate(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(shipping_rate_url(mock_shipping_rate))
      end
    end

    describe "with invalid params" do
      it "assigns the shipping_rate as @shipping_rate" do
        ShippingRate.stub(:find) { mock_shipping_rate(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:shipping_rate).should be(mock_shipping_rate)
      end

      it "re-renders the 'edit' template" do
        ShippingRate.stub(:find) { mock_shipping_rate(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested shipping_rate" do
      ShippingRate.should_receive(:find).with("37") { mock_shipping_rate }
      mock_shipping_rate.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the shipping_rates list" do
      ShippingRate.stub(:find) { mock_shipping_rate }
      delete :destroy, :id => "1"
      response.should redirect_to(shipping_rates_url)
    end
  end

end
