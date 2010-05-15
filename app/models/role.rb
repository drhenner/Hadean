class Role < ActiveRecord::Base
  
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :users,         :through => :user_roles
  
  validates_presence_of :name
  
  NAMES = ['super_administrator', 'administrator', 'warehouse', 'user', 'report', 'customer_service']
  
  USER_ID         = 4
  SUPER_ADMIN_ID  = 1
  ADMIN_ID        = 2
  WAREHOUSE_ID    = 3
  REPORT_ID       = 5
  CUSTOMER_SERVICE = 6
end
