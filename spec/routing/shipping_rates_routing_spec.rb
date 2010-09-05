require "spec_helper"

describe ShippingRatesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/shipping_rates" }.should route_to(:controller => "shipping_rates", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/shipping_rates/new" }.should route_to(:controller => "shipping_rates", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/shipping_rates/1" }.should route_to(:controller => "shipping_rates", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/shipping_rates/1/edit" }.should route_to(:controller => "shipping_rates", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/shipping_rates" }.should route_to(:controller => "shipping_rates", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/shipping_rates/1" }.should route_to(:controller => "shipping_rates", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/shipping_rates/1" }.should route_to(:controller => "shipping_rates", :action => "destroy", :id => "1")
    end

  end
end
