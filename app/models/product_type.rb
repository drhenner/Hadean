class ProductType < ActiveRecord::Base
  
  has_many :products
  
  has_many :prototype_properties_product_types
  has_many :prototype_properties,      :through => :prototype_properties_product_types
  
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]
    grid = ProductType.all
    grid.where("product_types.name = ?", params[:name])  if params[:name].present?
    grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
  
end
