class Supplier < ActiveRecord::Base
  
  has_many :variant_suppliers
  has_many :variants,         :through => :variant_suppliers
  has_many :phones
  
  validates :name,        :presence => true
  validates :email,       :format   => { :with => CustomValidators::Emails.email_validator }
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]
    
    grid = Supplier
    #grid.includes(:product)
    grid.where("suppliers.name = ?", params[:name])  if params[:name].present?
    grid.where("suppliers.email = ?", params[:email])  if params[:email].present?
    grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
end
