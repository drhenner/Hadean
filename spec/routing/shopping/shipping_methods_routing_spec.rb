require "spec_helper"

describe Shopping::ShippingMethodsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/shopping_shipping_methods" }.should route_to(:controller => "shopping_shipping_methods", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/shopping_shipping_methods/new" }.should route_to(:controller => "shopping_shipping_methods", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/shopping_shipping_methods/1" }.should route_to(:controller => "shopping_shipping_methods", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/shopping_shipping_methods/1/edit" }.should route_to(:controller => "shopping_shipping_methods", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/shopping_shipping_methods" }.should route_to(:controller => "shopping_shipping_methods", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/shopping_shipping_methods/1" }.should route_to(:controller => "shopping_shipping_methods", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/shopping_shipping_methods/1" }.should route_to(:controller => "shopping_shipping_methods", :action => "destroy", :id => "1")
    end

  end
end
