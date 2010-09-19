require "spec_helper"

describe Admin::Order::UsersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_order_users" }.should route_to(:controller => "admin_order_users", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_order_users/new" }.should route_to(:controller => "admin_order_users", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_order_users/1" }.should route_to(:controller => "admin_order_users", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_order_users/1/edit" }.should route_to(:controller => "admin_order_users", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_order_users" }.should route_to(:controller => "admin_order_users", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_order_users/1" }.should route_to(:controller => "admin_order_users", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_order_users/1" }.should route_to(:controller => "admin_order_users", :action => "destroy", :id => "1")
    end

  end
end
