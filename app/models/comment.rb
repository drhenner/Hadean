class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :created_by, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :user 
  
end
