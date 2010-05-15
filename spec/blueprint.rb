require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }
Sham.street_no { (1 .. 100).map.to_a.rand } 
Sham.street_name { Faker:: Address.street_name }

#Sham.street_type {(rand (2) == 1) ? 'Street' : 'road'} 

Sham.age(:unique => false){(1 .. 100).map.to_a.rand }
Sham.gender(:unique => false){ rand (2) }
Sham.birth_date do 
  Date.civil(
    (1990 ... 2009).to_a.rand, 
    (1 .. 12).to_a.rand, 
    (1 .. 28).to_a.rand
            )
end
Sham.address      { Faker::Address.street_address } 
Sham.city         { Faker::Address.city }
Sham.zip_code     { Faker::Address.zip_code }
Sham.phone_number { Faker::PhoneNumber.phone_number }

def make_admin_user(attributes = {})
  user = User.make(attributes)
  user.registration_info.make(:admin)
  user
end

