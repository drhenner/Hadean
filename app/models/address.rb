class Address < ActiveRecord::Base
  belongs_to  :state
  belongs_to  :address_type
  belongs_to  :addressable, :polymorphic => true
  
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state,       :if => Proc.new { |address| address.state_name.blank?  }
  validates_presence_of :state_name,  :if => Proc.new { |address| address.state_id.blank?   }
  #validates_presence_of :zip_code
  validates_presence_of :phone
  
  def save_default_address(object, params)
    Address.transaction do
      if params[:default] && params[:default] != '0'
        Address.update_all(["addresses.default = ?", false], 
                            ["addresses.addressable_id = ? AND addresses.addressable_type = ? ", object.id, object.class.to_s]) if object
        self.default = true
      end
      self.addressable = object
      self.save
      
    end
  end
end
