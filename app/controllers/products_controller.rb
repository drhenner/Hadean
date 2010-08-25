class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    form_info
  end
  
  private
  
  def form_info
    @cart_item = CartItem.new
  end
end
