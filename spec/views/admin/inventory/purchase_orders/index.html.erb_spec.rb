require 'spec_helper'

describe "purchase_orders/index.html.erb" do
  before(:each) do
    assign(:purchase_orders, [
      stub_model(PurchaseOrder,
        :supplier_id => 1,
        :invoice_number => "Invoice Number",
        :tracking_number => "Tracking Number",
        :notes => "Notes",
        :is_received => false
      ),
      stub_model(PurchaseOrder,
        :supplier_id => 1,
        :invoice_number => "Invoice Number",
        :tracking_number => "Tracking Number",
        :notes => "Notes",
        :is_received => false
      )
    ])
  end

  it "renders a list of purchase_orders" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Invoice Number".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Tracking Number".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Notes".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
