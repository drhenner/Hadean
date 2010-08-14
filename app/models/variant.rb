class Variant < ActiveRecord::Base
  
  
  has_many :variant_suppliers
  has_many :suppliers,         :through => :variant_suppliers
  
  has_many :variant_properties
  has_many :properties,          :through => :variant_properties
  
  belongs_to :product
  belongs_to :brand
  
  #validates :name,        :presence => true
  validates :price,       :presence => true
  validates :product_id,  :presence => true
  validates :sku,         :presence => true
  
  accepts_nested_attributes_for :variant_properties
  
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
