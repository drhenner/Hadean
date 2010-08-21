require "spec_helper"

describe CartItemsController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/cart_items" }.should route_to(:controller => "cart_items", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/cart_items/new" }.should route_to(:controller => "cart_items", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cart_items/1" }.should route_to(:controller => "cart_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cart_items/1/edit" }.should route_to(:controller => "cart_items", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cart_items" }.should route_to(:controller => "cart_items", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/cart_items/1" }.should route_to(:controller => "cart_items", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cart_items/1" }.should route_to(:controller => "cart_items", :action => "destroy", :id => "1")
    end

  end
end
