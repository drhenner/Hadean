class Property < ActiveRecord::Base
  
  has_many :prototype_properies
  has_many :prototypes,          :through => :prototype_properies
  
  has_many :product_properies
  has_many :products,          :through => :product_properies
  
  has_many :variant_properies
  has_many :variants,          :through => :variant_properies
  
  scope :visible, where("active == ?",true)
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= 25
    
    grid = Property
    grid.where("active == ?",true)                    unless  params[:show_all].present? && 
                                                              params[:show_all] == 'true'
    grid.where("properties.display_name = ?", params[:display_name])  if params[:display_name].present?
    grid.order("#{params[:sidx]} #{params[:sord]}").paginate(:page => params[:page], :per_page => params[:rows])

  end
  
end
