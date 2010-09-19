require 'spec_helper'

describe Admin::Order::ShippingAddressesController do

  def mock_shipping_address(stubs={})
    @mock_shipping_address ||= mock_model(Admin::Order::ShippingAddress, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_order_shipping_addresses as @admin_order_shipping_addresses" do
      Admin::Order::ShippingAddress.stub(:all) { [mock_shipping_address] }
      get :index
      assigns(:admin_order_shipping_addresses).should eq([mock_shipping_address])
    end
  end

  describe "GET show" do
    it "assigns the requested shipping_address as @shipping_address" do
      Admin::Order::ShippingAddress.stub(:find).with("37") { mock_shipping_address }
      get :show, :id => "37"
      assigns(:shipping_address).should be(mock_shipping_address)
    end
  end

  describe "GET new" do
    it "assigns a new shipping_address as @shipping_address" do
      Admin::Order::ShippingAddress.stub(:new) { mock_shipping_address }
      get :new
      assigns(:shipping_address).should be(mock_shipping_address)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipping_address as @shipping_address" do
      Admin::Order::ShippingAddress.stub(:find).with("37") { mock_shipping_address }
      get :edit, :id => "37"
      assigns(:shipping_address).should be(mock_shipping_address)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created shipping_address as @shipping_address" do
        Admin::Order::ShippingAddress.stub(:new).with({'these' => 'params'}) { mock_shipping_address(:save => true) }
        post :create, :shipping_address => {'these' => 'params'}
        assigns(:shipping_address).should be(mock_shipping_address)
      end

      it "redirects to the created shipping_address" do
        Admin::Order::ShippingAddress.stub(:new) { mock_shipping_address(:save => true) }
        post :create, :shipping_address => {}
        response.should redirect_to(admin_order_shipping_address_url(mock_shipping_address))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipping_address as @shipping_address" do
        Admin::Order::ShippingAddress.stub(:new).with({'these' => 'params'}) { mock_shipping_address(:save => false) }
        post :create, :shipping_address => {'these' => 'params'}
        assigns(:shipping_address).should be(mock_shipping_address)
      end

      it "re-renders the 'new' template" do
        Admin::Order::ShippingAddress.stub(:new) { mock_shipping_address(:save => false) }
        post :create, :shipping_address => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested shipping_address" do
        Admin::Order::ShippingAddress.should_receive(:find).with("37") { mock_shipping_address }
        mock_admin_order_shipping_address.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :shipping_address => {'these' => 'params'}
      end

      it "assigns the requested shipping_address as @shipping_address" do
        Admin::Order::ShippingAddress.stub(:find) { mock_shipping_address(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:shipping_address).should be(mock_shipping_address)
      end

      it "redirects to the shipping_address" do
        Admin::Order::ShippingAddress.stub(:find) { mock_shipping_address(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_order_shipping_address_url(mock_shipping_address))
      end
    end

    describe "with invalid params" do
      it "assigns the shipping_address as @shipping_address" do
        Admin::Order::ShippingAddress.stub(:find) { mock_shipping_address(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:shipping_address).should be(mock_shipping_address)
      end

      it "re-renders the 'edit' template" do
        Admin::Order::ShippingAddress.stub(:find) { mock_shipping_address(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested shipping_address" do
      Admin::Order::ShippingAddress.should_receive(:find).with("37") { mock_shipping_address }
      mock_admin_order_shipping_address.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_order_shipping_addresses list" do
      Admin::Order::ShippingAddress.stub(:find) { mock_shipping_address }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_order_shipping_addresses_url)
    end
  end

end
