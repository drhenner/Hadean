# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

usa = Country.find_by_abbreviation('USA')
Country.create(:name => 'United States', :abbreviation => 'USA') unless usa

canada = Country.find_by_abbreviation('CAN')
Country.create(:name => 'Canada', :abbreviation => 'CAN') unless canada

file_to_load  = Rails.root + 'db/seed/states.yml'
states_list   = YAML::load( File.open( file_to_load ) )


states_list.each_pair do |key,state|
  s = State.find_by_abbreviation(state['attributes']['abbreviation'])
  State.create(state['attributes']) unless s
end 

roles = Role::ROLES 
roles.each do |role|
  Role.find_or_create_by_name(role)
end

AddressType::NAMES.each do |address_type|
  AddressType.find_or_create_by_name(address_type)
end

PhoneType::NAMES.each do |phone_type|
  PhoneType.find_or_create_by_name(phone_type)
end

ItemType::NAMES.each do |item_type|
  ItemType.find_or_create_by_name(item_type)
end

Account::TYPES.each_pair do |acc_type, value|
  acc = Account.find_by_name(acc_type)
  unless acc
    Account.create(:name => acc_type, :account_type => acc_type, :monthly_charge => value)
  end
end

ShippingRateType::TYPES.each do |rate_type|
  ShippingRateType.find_or_create_by_name(rate_type)
end

ShippingZone::LOCATIONS.each do |loc|
  ShippingZone.find_or_create_by_name(loc)
end

TaxStatus::STATUSES.each do |status|
  TaxStatus.find_or_create_by_name(status)
end

TransactionAccount::ACCOUNT_TYPES.each do |acc_type|
  TransactionAccount.find_or_create_by_name(acc_type)
end
