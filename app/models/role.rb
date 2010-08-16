class Role < ActiveRecord::Base
  
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :users,         :through => :user_roles
  
  validates_presence_of :name
  
  SUPER_ADMIN       = 'super_administrator'
  ADMIN             = 'administrator'
  WAREHOUSE         = 'warehouse'
  USER              = 'user'
  REPORT            = 'report'
  CUSTOMER_SERVICE  = 'customer_service'
  
  ROLES = [ SUPER_ADMIN, 
            ADMIN, 
            WAREHOUSE, 
            USER, 
            REPORT, 
            CUSTOMER_SERVICE]
  
  NON_ADMIN_ROLES = [ WAREHOUSE, 
                      USER, 
                      REPORT, 
                      CUSTOMER_SERVICE]
  
  USER_ID             = 4
  SUPER_ADMIN_ID      = 1
  ADMIN_ID            = 2
  WAREHOUSE_ID        = 3
  REPORT_ID           = 5
  CUSTOMER_SERVICE_ID = 6
end
