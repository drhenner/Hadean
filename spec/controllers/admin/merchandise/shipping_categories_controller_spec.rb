require 'spec_helper'

describe Admin::Merchandise::ShippingCategoriesController do

  def mock_shipping_category(stubs={})
    @mock_shipping_category ||= mock_model(Admin::Merchandise::ShippingCategory, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_merchandise_shipping_categories as @admin_merchandise_shipping_categories" do
      Admin::Merchandise::ShippingCategory.stub(:all) { [mock_shipping_category] }
      get :index
      assigns(:admin_merchandise_shipping_categories).should eq([mock_shipping_category])
    end
  end

  describe "GET show" do
    it "assigns the requested shipping_category as @shipping_category" do
      Admin::Merchandise::ShippingCategory.stub(:find).with("37") { mock_shipping_category }
      get :show, :id => "37"
      assigns(:shipping_category).should be(mock_shipping_category)
    end
  end

  describe "GET new" do
    it "assigns a new shipping_category as @shipping_category" do
      Admin::Merchandise::ShippingCategory.stub(:new) { mock_shipping_category }
      get :new
      assigns(:shipping_category).should be(mock_shipping_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipping_category as @shipping_category" do
      Admin::Merchandise::ShippingCategory.stub(:find).with("37") { mock_shipping_category }
      get :edit, :id => "37"
      assigns(:shipping_category).should be(mock_shipping_category)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created shipping_category as @shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:new).with({'these' => 'params'}) { mock_shipping_category(:save => true) }
        post :create, :shipping_category => {'these' => 'params'}
        assigns(:shipping_category).should be(mock_shipping_category)
      end

      it "redirects to the created shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:new) { mock_shipping_category(:save => true) }
        post :create, :shipping_category => {}
        response.should redirect_to(admin_merchandise_shipping_category_url(mock_shipping_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipping_category as @shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:new).with({'these' => 'params'}) { mock_shipping_category(:save => false) }
        post :create, :shipping_category => {'these' => 'params'}
        assigns(:shipping_category).should be(mock_shipping_category)
      end

      it "re-renders the 'new' template" do
        Admin::Merchandise::ShippingCategory.stub(:new) { mock_shipping_category(:save => false) }
        post :create, :shipping_category => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested shipping_category" do
        Admin::Merchandise::ShippingCategory.should_receive(:find).with("37") { mock_shipping_category }
        mock_admin_merchandise_shipping_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :shipping_category => {'these' => 'params'}
      end

      it "assigns the requested shipping_category as @shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:find) { mock_shipping_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:shipping_category).should be(mock_shipping_category)
      end

      it "redirects to the shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:find) { mock_shipping_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_merchandise_shipping_category_url(mock_shipping_category))
      end
    end

    describe "with invalid params" do
      it "assigns the shipping_category as @shipping_category" do
        Admin::Merchandise::ShippingCategory.stub(:find) { mock_shipping_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:shipping_category).should be(mock_shipping_category)
      end

      it "re-renders the 'edit' template" do
        Admin::Merchandise::ShippingCategory.stub(:find) { mock_shipping_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested shipping_category" do
      Admin::Merchandise::ShippingCategory.should_receive(:find).with("37") { mock_shipping_category }
      mock_admin_merchandise_shipping_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_merchandise_shipping_categories list" do
      Admin::Merchandise::ShippingCategory.stub(:find) { mock_shipping_category }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_merchandise_shipping_categories_url)
    end
  end

end
