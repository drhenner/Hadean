require "spec_helper"

describe Admin::Checkout::ShipmentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/checkout/shipments" }.should route_to(:controller => "admin/checkout/shipments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/checkout/shipments/new" }.should route_to(:controller => "admin/checkout/shipments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/checkout/shipments/1" }.should route_to(:controller => "admin/checkout/shipments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/checkout/shipments/1/edit" }.should route_to(:controller => "admin/checkout/shipments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/checkout/shipments" }.should route_to(:controller => "admin/checkout/shipments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/checkout/shipments/1" }.should route_to(:controller => "admin/checkout/shipments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/checkout/shipments/1" }.should route_to(:controller => "admin/checkout/shipments", :action => "destroy", :id => "1")
    end

  end
end
