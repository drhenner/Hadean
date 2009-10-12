class Email < ActiveRecord::Base
  #attr_accessible :address#, :effective_at


  belongs_to :emailable, :polymorphic => true
  #belongs_to :user
end
