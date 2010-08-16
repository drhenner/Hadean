require "spec_helper"

describe PurchaseOrdersController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/purchase_orders" }.should route_to(:controller => "purchase_orders", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/purchase_orders/new" }.should route_to(:controller => "purchase_orders", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/purchase_orders/1" }.should route_to(:controller => "purchase_orders", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/purchase_orders/1/edit" }.should route_to(:controller => "purchase_orders", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/purchase_orders" }.should route_to(:controller => "purchase_orders", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/purchase_orders/1" }.should route_to(:controller => "purchase_orders", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/purchase_orders/1" }.should route_to(:controller => "purchase_orders", :action => "destroy", :id => "1")
    end

  end
end
