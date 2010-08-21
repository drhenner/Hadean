require 'spec_helper'

describe "cart_items/edit.html.erb" do
  before(:each) do
    @cart_item = assign(:cart_item, stub_model(Cart,
      :new_record? => false,
      :user_id => 1,
      :variant_id => 1,
      :active => false,
      :item_type_id => 1
    ))
  end

  it "renders the edit cart_item form" do
    render

    rendered.should have_selector("form", :action => cart_item_path(@cart_item), :method => "post") do |form|
      form.should have_selector("input#cart_item_user_id", :name => "cart_item[user_id]")
      form.should have_selector("input#cart_item_variant_id", :name => "cart_item[variant_id]")
      form.should have_selector("input#cart_item_active", :name => "cart_item[active]")
      form.should have_selector("input#cart_item_item_type_id", :name => "cart_item[item_type_id]")
    end
  end
end
