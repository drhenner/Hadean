class Product < ActiveRecord::Base
  
  belongs_to :product_type
  belongs_to :prototype
  belongs_to :shipping_category
  has_many :product_properties
  has_many :properties,          :through => :product_properties
  
  has_many :variants
  has_many :images, :as         => :imageable,
                    :order      => :position,
                    :dependent  => :destroy

  accepts_nested_attributes_for :variants
  accepts_nested_attributes_for :product_properties, :reject_if => proc { |attributes| attributes['description'].blank? }

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil? }
  
  validates :shipping_category_id,  :presence => true
  #validates :tax_category_id,      :presence => true
  validates :product_type_id,       :presence => true
  validates :prototype_id,          :presence => true


  def self.featured
    product = Product.where("products.featured = ? ", true).includes(:images).first
    product ? product : Product.includes(:images).first
  end
  
  def self.admin_grid(params = {})

    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = Product#paginate({:page => params[:page]})

    #grid.includes(:variants)
    grid.where("products.name = ?",                 params[:name])                  if params[:name].present?
    grid.where("products.product_type_id = ?",      params[:product_type_id])       if params[:product_type_id].present?
    grid.where("products.shipping_category_id = ?", params[:shipping_category_id])  if params[:shipping_category_id].present?
    grid.where("products.available_at > ?",         params[:available_at_gt])       if params[:available_at_gt].present?
    grid.where("products.available_at < ?",         params[:available_at_lt])       if params[:available_at_lt].present?
    grid.limit(params[:rows])
    grid.order("#{params[:sidx]} #{params[:sord]}").paginate(:page => params[:page], :per_page => params[:rows])
  end
end
