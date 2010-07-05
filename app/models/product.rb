class Product < ActiveRecord::Base
  
  belongs_to :product_type
  has_many :product_properies
  has_many :properies,          :through => :product_properies
  
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]
    
    grid = paginate({:page => params[:page]})
    
    #grid.includes(:variants)
    grid.where("products.name = ?",                 params[:name])                  if params[:name].present?
    grid.where("products.product_type_id = ?",      params[:product_type_id])       if params[:product_type_id].present?
    grid.where("products.shipping_category_id = ?", params[:shipping_category_id])  if params[:shipping_category_id].present?
    grid.where("products.available_at > ?",         params[:available_at_gt])       if params[:available_at_gt].present?
    grid.where("products.available_at < ?",         params[:available_at_lt])       if params[:available_at_lt].present?

    grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid.limit(params[:rows])
    grid
  end
end
