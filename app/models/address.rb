class Address < ActiveRecord::Base
  belongs_to  :state
  belongs_to  :address_type
  belongs_to  :addressable, :polymorphic => true
  has_many     :phones, :as => :phoneable
  
  validates :first_name,  :presence => true,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :last_name,   :presence => true,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :address1,    :presence => true
  validates :city,        :presence => true,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :state,       :presence => true,  :if => Proc.new { |address| address.state_name.blank?  }
  validates :state_name,  :presence => true,  :if => Proc.new { |address| address.state_id.blank?   }
  #validates :zip_code,   :presence => true
  #validates :phone_id,    :presence => true
  
  #accepts_nested_attributes_for :phones
  
  def save_default_address(object, params)
    Address.transaction do
      if params[:default] && params[:default] != '0'
        Address.update_all(["addresses.default = ?", false], 
                            ["addresses.addressable_id = ? AND 
                              addresses.address_type_id = ? AND
                              addresses.addressable_type = ? ", object.id, self.address_type_id, object.class.to_s]) if object
        self.default = true
      end
      self.addressable = object
      self.save
      
    end
  end
  
  
  def address_lines(join_chars = ', ')
    [address1, address2].delete_if{|add| add.blank?}.join(join_chars)
  end

  def state_abbr_name
    state ? state.abbr : state_name
  end

  def city_state_name
    [city, state_abbr_name].join(', ')
  end

  def city_state_zip
    [city_state_name, zipcode].join(' ')
  end
  
  def sanitize_data
    self.first_name  = self.first_name.strip  unless self.first_name.blank?
    self.last_name   = self.last_name.strip   unless self.last_name.blank?
    self.city       = self.city.strip       unless self.city.blank?
    self.zipcode    = self.zipcode.strip    unless self.zipcode.blank?
    self.phone      = self.phone.strip      unless self.phone.blank?
    self.address1   = self.address1.strip   unless self.address1.blank?
    self.address2   = self.address2.strip   unless self.address2.blank?
  end
end
