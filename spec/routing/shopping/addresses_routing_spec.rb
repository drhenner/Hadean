require "spec_helper"

describe Shopping::AddressesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/shopping_addresses" }.should route_to(:controller => "shopping_addresses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/shopping_addresses/new" }.should route_to(:controller => "shopping_addresses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/shopping_addresses/1" }.should route_to(:controller => "shopping_addresses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/shopping_addresses/1/edit" }.should route_to(:controller => "shopping_addresses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/shopping_addresses" }.should route_to(:controller => "shopping_addresses", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/shopping_addresses/1" }.should route_to(:controller => "shopping_addresses", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/shopping_addresses/1" }.should route_to(:controller => "shopping_addresses", :action => "destroy", :id => "1")
    end

  end
end
