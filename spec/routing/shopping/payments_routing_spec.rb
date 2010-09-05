require "spec_helper"

describe Shopping::PaymentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/shopping_payments" }.should route_to(:controller => "shopping_payments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/shopping_payments/new" }.should route_to(:controller => "shopping_payments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/shopping_payments/1" }.should route_to(:controller => "shopping_payments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/shopping_payments/1/edit" }.should route_to(:controller => "shopping_payments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/shopping_payments" }.should route_to(:controller => "shopping_payments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/shopping_payments/1" }.should route_to(:controller => "shopping_payments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/shopping_payments/1" }.should route_to(:controller => "shopping_payments", :action => "destroy", :id => "1")
    end

  end
end
