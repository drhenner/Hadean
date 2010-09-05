require "spec_helper"

describe Admin::Config::ShippingZonesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_config_shipping_zones" }.should route_to(:controller => "admin_config_shipping_zones", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_config_shipping_zones/new" }.should route_to(:controller => "admin_config_shipping_zones", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_config_shipping_zones/1" }.should route_to(:controller => "admin_config_shipping_zones", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_config_shipping_zones/1/edit" }.should route_to(:controller => "admin_config_shipping_zones", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_config_shipping_zones" }.should route_to(:controller => "admin_config_shipping_zones", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_config_shipping_zones/1" }.should route_to(:controller => "admin_config_shipping_zones", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_config_shipping_zones/1" }.should route_to(:controller => "admin_config_shipping_zones", :action => "destroy", :id => "1")
    end

  end
end
