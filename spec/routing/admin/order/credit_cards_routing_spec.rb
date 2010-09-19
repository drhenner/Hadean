require "spec_helper"

describe Admin::Order::CreditCardsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_order_credit_cards" }.should route_to(:controller => "admin_order_credit_cards", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_order_credit_cards/new" }.should route_to(:controller => "admin_order_credit_cards", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_order_credit_cards/1" }.should route_to(:controller => "admin_order_credit_cards", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_order_credit_cards/1/edit" }.should route_to(:controller => "admin_order_credit_cards", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_order_credit_cards" }.should route_to(:controller => "admin_order_credit_cards", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_order_credit_cards/1" }.should route_to(:controller => "admin_order_credit_cards", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_order_credit_cards/1" }.should route_to(:controller => "admin_order_credit_cards", :action => "destroy", :id => "1")
    end

  end
end
