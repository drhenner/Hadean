require 'spec_helper'

describe "purchase_orders/edit.html.erb" do
  before(:each) do
    @purchase_order = assign(:purchase_order, stub_model(PurchaseOrder,
      :new_record? => false,
      :supplier_id => 1,
      :invoice_number => "MyString",
      :tracking_number => "MyString",
      :notes => "MyString",
      :is_received => false
    ))
  end

  it "renders the edit purchase_order form" do
    render

    rendered.should have_selector("form", :action => purchase_order_path(@purchase_order), :method => "post") do |form|
      form.should have_selector("input#purchase_order_supplier_id", :name => "purchase_order[supplier_id]")
      form.should have_selector("input#purchase_order_invoice_number", :name => "purchase_order[invoice_number]")
      form.should have_selector("input#purchase_order_tracking_number", :name => "purchase_order[tracking_number]")
      form.should have_selector("input#purchase_order_notes", :name => "purchase_order[notes]")
      form.should have_selector("input#purchase_order_is_received", :name => "purchase_order[is_received]")
    end
  end
end
