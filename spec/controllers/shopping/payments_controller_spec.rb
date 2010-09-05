require 'spec_helper'

describe Shopping::PaymentsController do

  def mock_payment(stubs={})
    @mock_payment ||= mock_model(Shopping::Payment, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all shopping_payments as @shopping_payments" do
      Shopping::Payment.stub(:all) { [mock_payment] }
      get :index
      assigns(:shopping_payments).should eq([mock_payment])
    end
  end

  describe "GET show" do
    it "assigns the requested payment as @payment" do
      Shopping::Payment.stub(:find).with("37") { mock_payment }
      get :show, :id => "37"
      assigns(:payment).should be(mock_payment)
    end
  end

  describe "GET new" do
    it "assigns a new payment as @payment" do
      Shopping::Payment.stub(:new) { mock_payment }
      get :new
      assigns(:payment).should be(mock_payment)
    end
  end

  describe "GET edit" do
    it "assigns the requested payment as @payment" do
      Shopping::Payment.stub(:find).with("37") { mock_payment }
      get :edit, :id => "37"
      assigns(:payment).should be(mock_payment)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created payment as @payment" do
        Shopping::Payment.stub(:new).with({'these' => 'params'}) { mock_payment(:save => true) }
        post :create, :payment => {'these' => 'params'}
        assigns(:payment).should be(mock_payment)
      end

      it "redirects to the created payment" do
        Shopping::Payment.stub(:new) { mock_payment(:save => true) }
        post :create, :payment => {}
        response.should redirect_to(shopping_payment_url(mock_payment))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved payment as @payment" do
        Shopping::Payment.stub(:new).with({'these' => 'params'}) { mock_payment(:save => false) }
        post :create, :payment => {'these' => 'params'}
        assigns(:payment).should be(mock_payment)
      end

      it "re-renders the 'new' template" do
        Shopping::Payment.stub(:new) { mock_payment(:save => false) }
        post :create, :payment => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested payment" do
        Shopping::Payment.should_receive(:find).with("37") { mock_payment }
        mock_shopping_payment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :payment => {'these' => 'params'}
      end

      it "assigns the requested payment as @payment" do
        Shopping::Payment.stub(:find) { mock_payment(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:payment).should be(mock_payment)
      end

      it "redirects to the payment" do
        Shopping::Payment.stub(:find) { mock_payment(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(shopping_payment_url(mock_payment))
      end
    end

    describe "with invalid params" do
      it "assigns the payment as @payment" do
        Shopping::Payment.stub(:find) { mock_payment(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:payment).should be(mock_payment)
      end

      it "re-renders the 'edit' template" do
        Shopping::Payment.stub(:find) { mock_payment(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested payment" do
      Shopping::Payment.should_receive(:find).with("37") { mock_payment }
      mock_shopping_payment.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the shopping_payments list" do
      Shopping::Payment.stub(:find) { mock_payment }
      delete :destroy, :id => "1"
      response.should redirect_to(shopping_payments_url)
    end
  end

end
