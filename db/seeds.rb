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
