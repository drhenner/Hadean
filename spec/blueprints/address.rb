
Address.blueprint do 
  first_name  { Sham.name }
  last_name   { Sham.name }
  address1    { Sham.address }
  city        { Sham.city }
  state       { State.first }#,       :if => Proc.new { |address| address.state_name.blank?  }
  state_name   nil #,  :if => Proc.new { |address| address.state_id.blank?   }
  zip_code
  phone       { Sham.phone_number }
end