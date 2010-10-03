require 'spec_helper'

describe "return_authorizations/edit.html.erb" do
  before(:each) do
    @return_authorization = assign(:return_authorization, stub_model(ReturnAuthorization,
      :new_record? => false,
      :number => "MyString",
      :amount => "9.99",
      :restocking_fee => "9.99",
      :order_id => 1,
      :state => "MyString",
      :created_by => 1
    ))
  end

  it "renders the edit return_authorization form" do
    render

    rendered.should have_selector("form", :action => return_authorization_path(@return_authorization), :method => "post") do |form|
      form.should have_selector("input#return_authorization_number", :name => "return_authorization[number]")
      form.should have_selector("input#return_authorization_amount", :name => "return_authorization[amount]")
      form.should have_selector("input#return_authorization_restocking_fee", :name => "return_authorization[restocking_fee]")
      form.should have_selector("input#return_authorization_order_id", :name => "return_authorization[order_id]")
      form.should have_selector("input#return_authorization_state", :name => "return_authorization[state]")
      form.should have_selector("input#return_authorization_created_by", :name => "return_authorization[created_by]")
    end
  end
end
