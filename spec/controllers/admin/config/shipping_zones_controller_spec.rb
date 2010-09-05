require 'spec_helper'

describe Admin::Config::ShippingZonesController do

  def mock_shipping_zone(stubs={})
    @mock_shipping_zone ||= mock_model(Admin::Config::ShippingZone, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_config_shipping_zones as @admin_config_shipping_zones" do
      Admin::Config::ShippingZone.stub(:all) { [mock_shipping_zone] }
      get :index
      assigns(:admin_config_shipping_zones).should eq([mock_shipping_zone])
    end
  end

  describe "GET show" do
    it "assigns the requested shipping_zone as @shipping_zone" do
      Admin::Config::ShippingZone.stub(:find).with("37") { mock_shipping_zone }
      get :show, :id => "37"
      assigns(:shipping_zone).should be(mock_shipping_zone)
    end
  end

  describe "GET new" do
    it "assigns a new shipping_zone as @shipping_zone" do
      Admin::Config::ShippingZone.stub(:new) { mock_shipping_zone }
      get :new
      assigns(:shipping_zone).should be(mock_shipping_zone)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipping_zone as @shipping_zone" do
      Admin::Config::ShippingZone.stub(:find).with("37") { mock_shipping_zone }
      get :edit, :id => "37"
      assigns(:shipping_zone).should be(mock_shipping_zone)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created shipping_zone as @shipping_zone" do
        Admin::Config::ShippingZone.stub(:new).with({'these' => 'params'}) { mock_shipping_zone(:save => true) }
        post :create, :shipping_zone => {'these' => 'params'}
        assigns(:shipping_zone).should be(mock_shipping_zone)
      end

      it "redirects to the created shipping_zone" do
        Admin::Config::ShippingZone.stub(:new) { mock_shipping_zone(:save => true) }
        post :create, :shipping_zone => {}
        response.should redirect_to(admin_config_shipping_zone_url(mock_shipping_zone))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipping_zone as @shipping_zone" do
        Admin::Config::ShippingZone.stub(:new).with({'these' => 'params'}) { mock_shipping_zone(:save => false) }
        post :create, :shipping_zone => {'these' => 'params'}
        assigns(:shipping_zone).should be(mock_shipping_zone)
      end

      it "re-renders the 'new' template" do
        Admin::Config::ShippingZone.stub(:new) { mock_shipping_zone(:save => false) }
        post :create, :shipping_zone => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested shipping_zone" do
        Admin::Config::ShippingZone.should_receive(:find).with("37") { mock_shipping_zone }
        mock_admin_config_shipping_zone.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :shipping_zone => {'these' => 'params'}
      end

      it "assigns the requested shipping_zone as @shipping_zone" do
        Admin::Config::ShippingZone.stub(:find) { mock_shipping_zone(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:shipping_zone).should be(mock_shipping_zone)
      end

      it "redirects to the shipping_zone" do
        Admin::Config::ShippingZone.stub(:find) { mock_shipping_zone(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_config_shipping_zone_url(mock_shipping_zone))
      end
    end

    describe "with invalid params" do
      it "assigns the shipping_zone as @shipping_zone" do
        Admin::Config::ShippingZone.stub(:find) { mock_shipping_zone(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:shipping_zone).should be(mock_shipping_zone)
      end

      it "re-renders the 'edit' template" do
        Admin::Config::ShippingZone.stub(:find) { mock_shipping_zone(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested shipping_zone" do
      Admin::Config::ShippingZone.should_receive(:find).with("37") { mock_shipping_zone }
      mock_admin_config_shipping_zone.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_config_shipping_zones list" do
      Admin::Config::ShippingZone.stub(:find) { mock_shipping_zone }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_config_shipping_zones_url)
    end
  end

end
