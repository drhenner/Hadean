require 'spec_helper'

describe "purchase_orders/show.html.erb" do
  before(:each) do
    @purchase_order = assign(:purchase_order, stub_model(PurchaseOrder,
      :supplier_id => 1,
      :invoice_number => "Invoice Number",
      :tracking_number => "Tracking Number",
      :notes => "Notes",
      :is_received => false
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain("Invoice Number".to_s)
    rendered.should contain("Tracking Number".to_s)
    rendered.should contain("Notes".to_s)
    rendered.should contain(false.to_s)
  end
end
