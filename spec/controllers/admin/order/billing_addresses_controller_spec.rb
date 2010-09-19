require 'spec_helper'

describe Admin::Order::BillingAddressesController do

  def mock_billing_address(stubs={})
    @mock_billing_address ||= mock_model(Admin::Order::BillingAddress, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_order_billing_addresses as @admin_order_billing_addresses" do
      Admin::Order::BillingAddress.stub(:all) { [mock_billing_address] }
      get :index
      assigns(:admin_order_billing_addresses).should eq([mock_billing_address])
    end
  end

  describe "GET show" do
    it "assigns the requested billing_address as @billing_address" do
      Admin::Order::BillingAddress.stub(:find).with("37") { mock_billing_address }
      get :show, :id => "37"
      assigns(:billing_address).should be(mock_billing_address)
    end
  end

  describe "GET new" do
    it "assigns a new billing_address as @billing_address" do
      Admin::Order::BillingAddress.stub(:new) { mock_billing_address }
      get :new
      assigns(:billing_address).should be(mock_billing_address)
    end
  end

  describe "GET edit" do
    it "assigns the requested billing_address as @billing_address" do
      Admin::Order::BillingAddress.stub(:find).with("37") { mock_billing_address }
      get :edit, :id => "37"
      assigns(:billing_address).should be(mock_billing_address)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created billing_address as @billing_address" do
        Admin::Order::BillingAddress.stub(:new).with({'these' => 'params'}) { mock_billing_address(:save => true) }
        post :create, :billing_address => {'these' => 'params'}
        assigns(:billing_address).should be(mock_billing_address)
      end

      it "redirects to the created billing_address" do
        Admin::Order::BillingAddress.stub(:new) { mock_billing_address(:save => true) }
        post :create, :billing_address => {}
        response.should redirect_to(admin_order_billing_address_url(mock_billing_address))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved billing_address as @billing_address" do
        Admin::Order::BillingAddress.stub(:new).with({'these' => 'params'}) { mock_billing_address(:save => false) }
        post :create, :billing_address => {'these' => 'params'}
        assigns(:billing_address).should be(mock_billing_address)
      end

      it "re-renders the 'new' template" do
        Admin::Order::BillingAddress.stub(:new) { mock_billing_address(:save => false) }
        post :create, :billing_address => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested billing_address" do
        Admin::Order::BillingAddress.should_receive(:find).with("37") { mock_billing_address }
        mock_admin_order_billing_address.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :billing_address => {'these' => 'params'}
      end

      it "assigns the requested billing_address as @billing_address" do
        Admin::Order::BillingAddress.stub(:find) { mock_billing_address(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:billing_address).should be(mock_billing_address)
      end

      it "redirects to the billing_address" do
        Admin::Order::BillingAddress.stub(:find) { mock_billing_address(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_order_billing_address_url(mock_billing_address))
      end
    end

    describe "with invalid params" do
      it "assigns the billing_address as @billing_address" do
        Admin::Order::BillingAddress.stub(:find) { mock_billing_address(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:billing_address).should be(mock_billing_address)
      end

      it "re-renders the 'edit' template" do
        Admin::Order::BillingAddress.stub(:find) { mock_billing_address(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested billing_address" do
      Admin::Order::BillingAddress.should_receive(:find).with("37") { mock_billing_address }
      mock_admin_order_billing_address.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_order_billing_addresses list" do
      Admin::Order::BillingAddress.stub(:find) { mock_billing_address }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_order_billing_addresses_url)
    end
  end

end
