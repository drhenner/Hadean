require 'spec_helper'

describe "cart_items/show.html.erb" do
  before(:each) do
    @cart_item = assign(:cart_item, stub_model(Cart,
      :user_id => 1,
      :variant_id => 1,
      :active => false,
      :item_type_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(false.to_s)
    rendered.should contain(1.to_s)
  end
end
