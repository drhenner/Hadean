class ReturnAuthorization < ActiveRecord::Base
  has_many   :return_items
  has_many   :comments, :as => :commentable
  
  # has_many :transactions
end
