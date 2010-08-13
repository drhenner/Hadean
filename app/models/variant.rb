class Variant < ActiveRecord::Base
  
  has_many :variant_properies
  has_many :properies,          :through => :variant_properies
  
  belongs_to :product
  
  validates :name,        :presence => true
  validates :price,       :presence => true
  validates :product_id,  :presence => true
  validates :sku,         :presence => true
  
  def product_name 
    product.name
  end
  
  def self.admin_grid(product, params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = Table(:variants)
    
    grid = Variant.where("variants.product_id", product.id)
    grid.includes(:product)
    grid.where("products.name = ?", params[:name])  if params[:name].present?
    grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
  
end
