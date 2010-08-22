=begin
require 'spec_helper'

describe Admin::Inventory::PurchaseOrdersController do

  def mock_purchase_order(stubs={})
    @mock_purchase_order ||= mock_model(PurchaseOrder, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all purchase_orders as @purchase_orders" do
      PurchaseOrder.stub(:all) { [mock_purchase_order] }
      get :index
      assigns(:purchase_orders).should eq([mock_purchase_order])
    end
  end

  describe "GET show" do
    it "assigns the requested purchase_order as @purchase_order" do
      PurchaseOrder.stub(:find).with("37") { mock_purchase_order }
      get :show, :id => "37"
      assigns(:purchase_order).should be(mock_purchase_order)
    end
  end

  describe "GET new" do
    it "assigns a new purchase_order as @purchase_order" do
      PurchaseOrder.stub(:new) { mock_purchase_order }
      get :new
      assigns(:purchase_order).should be(mock_purchase_order)
    end
  end

  describe "GET edit" do
    it "assigns the requested purchase_order as @purchase_order" do
      PurchaseOrder.stub(:find).with("37") { mock_purchase_order }
      get :edit, :id => "37"
      assigns(:purchase_order).should be(mock_purchase_order)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created purchase_order as @purchase_order" do
        PurchaseOrder.stub(:new).with({'these' => 'params'}) { mock_purchase_order(:save => true) }
        post :create, :purchase_order => {'these' => 'params'}
        assigns(:purchase_order).should be(mock_purchase_order)
      end

      it "redirects to the created purchase_order" do
        PurchaseOrder.stub(:new) { mock_purchase_order(:save => true) }
        post :create, :purchase_order => {}
        response.should redirect_to(purchase_order_url(mock_purchase_order))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved purchase_order as @purchase_order" do
        PurchaseOrder.stub(:new).with({'these' => 'params'}) { mock_purchase_order(:save => false) }
        post :create, :purchase_order => {'these' => 'params'}
        assigns(:purchase_order).should be(mock_purchase_order)
      end

      it "re-renders the 'new' template" do
        PurchaseOrder.stub(:new) { mock_purchase_order(:save => false) }
        post :create, :purchase_order => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested purchase_order" do
        PurchaseOrder.should_receive(:find).with("37") { mock_purchase_order }
        mock_purchase_order.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :purchase_order => {'these' => 'params'}
      end

      it "assigns the requested purchase_order as @purchase_order" do
        PurchaseOrder.stub(:find) { mock_purchase_order(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:purchase_order).should be(mock_purchase_order)
      end

      it "redirects to the purchase_order" do
        PurchaseOrder.stub(:find) { mock_purchase_order(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(purchase_order_url(mock_purchase_order))
      end
    end

    describe "with invalid params" do
      it "assigns the purchase_order as @purchase_order" do
        PurchaseOrder.stub(:find) { mock_purchase_order(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:purchase_order).should be(mock_purchase_order)
      end

      it "re-renders the 'edit' template" do
        PurchaseOrder.stub(:find) { mock_purchase_order(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested purchase_order" do
      PurchaseOrder.should_receive(:find).with("37") { mock_purchase_order }
      mock_purchase_order.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the purchase_orders list" do
      PurchaseOrder.stub(:find) { mock_purchase_order }
      delete :destroy, :id => "1"
      response.should redirect_to(purchase_orders_url)
    end
  end

end
=end