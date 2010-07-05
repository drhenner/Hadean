class Country < ActiveRecord::Base
  
  has_many :states
  
  validates :name,  :presence => true
  validates :abbreviation,  :presence => true
end
