require "spec_helper"

describe Shopping::OrdersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/shopping_orders" }.should route_to(:controller => "shopping_orders", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/shopping_orders/new" }.should route_to(:controller => "shopping_orders", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/shopping_orders/1" }.should route_to(:controller => "shopping_orders", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/shopping_orders/1/edit" }.should route_to(:controller => "shopping_orders", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/shopping_orders" }.should route_to(:controller => "shopping_orders", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/shopping_orders/1" }.should route_to(:controller => "shopping_orders", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/shopping_orders/1" }.should route_to(:controller => "shopping_orders", :action => "destroy", :id => "1")
    end

  end
end
