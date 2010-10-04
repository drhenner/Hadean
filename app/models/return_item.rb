class ReturnItem < ActiveRecord::Base
  belongs_to :return_reason
  belongs_to :return_condition
  
  belongs_to :return_authorization
  belongs_to :order_item
  belongs_to :last_author, :class_name => 'User', :foreign_key => :updated_by
  belongs_to :author, :class_name => 'User', :foreign_key => "created_by"
end
