require "spec_helper"

describe Admin::Order::ShippingAddressesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_order_shipping_addresses" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_order_shipping_addresses/new" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_order_shipping_addresses/1" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_order_shipping_addresses/1/edit" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_order_shipping_addresses" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_order_shipping_addresses/1" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_order_shipping_addresses/1" }.should route_to(:controller => "admin_order_shipping_addresses", :action => "destroy", :id => "1")
    end

  end
end
