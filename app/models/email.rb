class Email < ActiveRecord::Base
  attr_accessible :address


  belongs_to :emailable, :polymorphic => true
  belongs_to :user
end
