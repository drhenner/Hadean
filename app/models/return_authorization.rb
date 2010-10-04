class ReturnAuthorization < ActiveRecord::Base
  has_many   :return_items
  has_many   :comments, :as => :commentable
  
  belongs_to :author, :class_name => 'User', :foreign_key => :created_by
  # has_many :transactions
end
