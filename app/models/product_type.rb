class ProductType < ActiveRecord::Base
  
  has_many :products
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]
    
    grid = ProductType
    grid.where("product_types.name LIKE '?'", params[:name])              if params[:name].present?
    grid.where("product_types.name LIKE '?%'", params[:name_starts_with]) if params[:name_starts_with].present?
    grid.where("product_types.name LIKE '%?%'", params[:name_contains])   if params[:name_contains].present?
    grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
  
end
