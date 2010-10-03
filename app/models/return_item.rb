class ReturnItem < ActiveRecord::Base
  belongs_to :return_reason
  belongs_to :return_condition
  
  belongs_to :return_authorization
  belongs_to :order_item
  
end
