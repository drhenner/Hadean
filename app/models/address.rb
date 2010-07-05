class Address < ActiveRecord::Base
  belongs_to  :state
  belongs_to  :address_type
  belongs_to  :addressable, :polymorphic => true
  
  
  validates :first_name,  :presence => true
  validates :last_name,   :presence => true
  validates :address1,    :presence => true
  validates :city,        :presence => true
  validates :state,       :presence => true,  :if => Proc.new { |address| address.state_name.blank?  }
  validates :state_name,  :presence => true,  :if => Proc.new { |address| address.state_id.blank?   }
  #validates :zip_code,   :presence => true
  validates :phone,       :presence => true
  
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
