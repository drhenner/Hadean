require "spec_helper"

describe Admin::Config::TaxRatesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/config/tax_rates" }.should route_to(:controller => "admin/config/tax_rates", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/config/tax_rates/new" }.should route_to(:controller => "admin/config/tax_rates", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/config/tax_rates/1" }.should route_to(:controller => "admin/config/tax_rates", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/config/tax_rates/1/edit" }.should route_to(:controller => "admin/config/tax_rates", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/config/tax_rates" }.should route_to(:controller => "admin/config/tax_rates", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/config/tax_rates/1" }.should route_to(:controller => "admin/config/tax_rates", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/config/tax_rates/1" }.should route_to(:controller => "admin/config/tax_rates", :action => "destroy", :id => "1")
    end

  end
end
