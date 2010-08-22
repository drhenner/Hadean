class WelcomeController < ApplicationController
  
  def index
    @featured_product = Product.featured
    @other_products  ## search 2 or 3 categories (maybe based on the user)
  end
end
