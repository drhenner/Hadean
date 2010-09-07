class TaxStatus < ActiveRecord::Base
  has_many :products
  has_many :tax_rates
  
  #FOOD = 'Food'
  CLOTHES   = 'Clothes'
  COSMETICS = 'Cosmetics'
  
  STATUSES = [CLOTHES, COSMETICS]
  
  CLOTHES_ID    = 1
  COSMETICS_ID  = 2
  
  validates :name, :presence => true, :uniqueness => true
end
