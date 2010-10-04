class ReturnAuthorization < ActiveRecord::Base
  has_many   :return_items
  has_many   :comments, :as => :commentable
  
  belongs_to :user
  belongs_to :author, :class_name => 'User', :foreign_key => :created_by
  # has_many :transactions
  
  def order_number
    order.number
  end
  
  def user_name
    user.name
  end
  
  def self.admin_grid(params)

    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = ReturnAuthorization.includes([:order, :user])#paginate({:page => params[:page]})

    grid = grid.where("return_authorizations.number LIKE ?",  "#{params[:number]}%")        if params[:number].present?
    grid = grid.where("orders.order_number LIKE ?",           "#{params[:order_number]}%")  if params[:order_number].present?
    grid = grid.where("return_authorizations.state = ?",      params[:state])               if params[:state].present?
    grid = grid.limit(params[:rows])
    grid = grid.order("#{params[:sidx]} #{params[:sord]}").paginate(:page => params[:page], :per_page => params[:rows])
  end
end
