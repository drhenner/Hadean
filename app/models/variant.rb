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
  
  def product_tax_rate(state_id, tax_time = Time.now)
    product.tax_rate(state_id, tax_time)
  end
  
  def shipping_category_id
    product.shipping_category_id
  end
  
  def display_property_details(separator = '<br/>')
    property_details.join(separator)
  end
  
  def property_details(separator = ': ')
    variant_properties.collect {|vp| [vp.property.display_name ,vp.description].join(separator) }
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
  
  def is_available?
    count_available > 0
  end
  
  def count_available(reload_variant = true)
    self.reload if reload_variant
    count_on_hand - pending_to_customer
  end
  
  def add_count_on_hand(num)
      sql = "UPDATE variants SET count_on_hand = (#{num} + count_on_hand) WHERE id = #{self.id}"
      ActiveRecord::Base.connection.execute(sql)
  end
  
  def add_pending_to_customer(num)
      sql = "UPDATE variants SET count_pending_to_customer = (#{num} + count_pending_to_customer) WHERE id = #{self.id}"
      ActiveRecord::Base.connection.execute(sql)
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
