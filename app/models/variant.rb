class Variant < ActiveRecord::Base
  
  
  has_many :variant_suppliers
  has_many :suppliers,         :through => :variant_suppliers
  
  has_many :variant_properties
  has_many :properties,          :through => :variant_properties
  
  has_many   :purchase_order_variants
  has_many   :purchase_orders, :through => :purchase_order_variants
  
  belongs_to :product
  belongs_to :brand
  
  #validates :name,        :presence => true
  validates :price,       :presence => true
  validates :product_id,  :presence => true
  validates :sku,         :presence => true
  
  accepts_nested_attributes_for :variant_properties
  
  tax_time = completed_at? ? completed_at : Time.zone.now
  order_items.each do |item|
    rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)
    if item.tax_rate_id != rate.id 
      item.tax_rate = rate
      item.save
    end
  end
  
  def product_tax_rate(state_id, tax_time = Time.now)
    product.tax_rate(state_id, tax_time)
  end
  
  def display_property_details(separator = '<br/>')
    property_details.inject {|detail| detail.join(separator) }.join(': ')
  end
  
  def property_details
    variant_properties.collect {|vp| [vp.property.display_name ,vp.description] }
  end
  
  def product_name 
    product.name
  end
  
  def name_with_sku
    [product_name, sku].compact.join(': ')
  end
  
  def qty_to_add
    0
  end
  
  def add_pending_to_customer(num, reload_object = true)
    self.reload if reload_object
    self.count_pending_to_customer = self.count_pending_to_customer + num.to_i
    save
  end
  
  def qty_to_add=(num)
    ###  TODO this method needs a history of who did what
    self.count_on_hand = self.count_on_hand + num.to_i
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
