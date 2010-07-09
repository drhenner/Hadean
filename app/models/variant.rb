class Variant < ActiveRecord::Base
  
  has_many :variant_properies
  has_many :properies,          :through => :variant_properies
  
  
  validates :name,    :presence => true
  
  def self.admin_grid(product, params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = Table(:variants)
    
    grid = Variant.where("variants.product_id", product.id)
    grid.includes(:product)
    grid.where("variants.name = ?", params[:name])  if params[:name].present?
    grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
  
end
