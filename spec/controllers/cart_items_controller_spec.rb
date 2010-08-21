require 'spec_helper'

describe CartItemsController do

  def mock_cart_item(stubs={})
    @mock_cart_item ||= mock_model(CartItem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all cart_items as @cart_items" do
      CartItem.stub(:all) { [mock_cart_item] }
      get :index
      assigns(:cart_items).should eq([mock_cart_item])
    end
  end

  describe "GET show" do
    it "assigns the requested cart_item as @cart_item" do
      CartItem.stub(:find).with("37") { mock_cart_item }
      get :show, :id => "37"
      assigns(:cart_item).should be(mock_cart_item)
    end
  end

  describe "GET new" do
    it "assigns a new cart_item as @cart_item" do
      CartItem.stub(:new) { mock_cart_item }
      get :new
      assigns(:cart_item).should be(mock_cart_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested cart_item as @cart_item" do
      CartItem.stub(:find).with("37") { mock_cart_item }
      get :edit, :id => "37"
      assigns(:cart_item).should be(mock_cart_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created cart_item as @cart_item" do
        CartItem.stub(:new).with({'these' => 'params'}) { mock_cart_item(:save => true) }
        post :create, :cart_item => {'these' => 'params'}
        assigns(:cart_item).should be(mock_cart_item)
      end

      it "redirects to the created cart_item" do
        CartItem.stub(:new) { mock_cart_item(:save => true) }
        post :create, :cart_item => {}
        response.should redirect_to(cart_item_url(mock_cart_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cart_item as @cart_item" do
        CartItem.stub(:new).with({'these' => 'params'}) { mock_cart_item(:save => false) }
        post :create, :cart_item => {'these' => 'params'}
        assigns(:cart_item).should be(mock_cart_item)
      end

      it "re-renders the 'new' template" do
        CartItem.stub(:new) { mock_cart_item(:save => false) }
        post :create, :cart_item => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested cart_item" do
        CartItem.should_receive(:find).with("37") { mock_cart_item }
        mock_cart_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :cart_item => {'these' => 'params'}
      end

      it "assigns the requested cart_item as @cart_item" do
        CartItem.stub(:find) { mock_cart_item(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:cart_item).should be(mock_cart_item)
      end

      it "redirects to the cart_item" do
        CartItem.stub(:find) { mock_cart_item(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(cart_item_url(mock_cart_item))
      end
    end

    describe "with invalid params" do
      it "assigns the cart_item as @cart_item" do
        CartItem.stub(:find) { mock_cart_item(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:cart_item).should be(mock_cart_item)
      end

      it "re-renders the 'edit' template" do
        CartItem.stub(:find) { mock_cart_item(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested cart_item" do
      CartItem.should_receive(:find).with("37") { mock_cart_item }
      mock_cart_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the cart_items list" do
      CartItem.stub(:find) { mock_cart_item }
      delete :destroy, :id => "1"
      response.should redirect_to(cart_items_url)
    end
  end

end
