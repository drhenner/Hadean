require 'spec_helper'

describe "cart_items/index.html.erb" do
  before(:each) do
    assign(:cart_items, [
      stub_model(Cart,
        :user_id => 1,
        :variant_id => 1,
        :active => false,
        :item_type_id => 1
      ),
      stub_model(Cart,
        :user_id => 1,
        :variant_id => 1,
        :active => false,
        :item_type_id => 1
      )
    ])
  end

  it "renders a list of cart_items" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
