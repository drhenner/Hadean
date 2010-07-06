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
    #grid = Property.all
    grid = Property#.all #Table(:properties)
    grid.where("active == ?",true)                    unless  params[:show_all].present? && 
                                                              params[:show_all] == 'true'
    grid.where("properties.display_name = ?", params[:display_name])  if params[:display_name].present?
    grid.order("#{params[:sidx]} #{params[:sord]}").paginate(:page => params[:page], :per_page => params[:rows])
    #grid.limit(params[:rows].to_i)


  end
  
  
  
end
=begin
Property.paginate(:page       => params[:page], 
                  :per_page   => params[:rows], 
                  :conditions => grid.to_sql
                  )
                  
Mysql::Error: Operand should contain 1 column(s): 
SELECT     `properties`.* 
FROM       `properties` 
WHERE     
  (SELECT     `properties`.`id`, `properties`.`identifing_name`, `properties`.`display_name`, `properties`.`active` 
    FROM       `properties`) 
LIMIT 0, 25

=end