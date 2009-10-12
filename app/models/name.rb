class Name < ActiveRecord::Base
  #attr_accessible :first, :last, :middle, :suffix, :nickname, :title, :deleted_at, :effective_at, :active, :inactive_at, :person_id, :nameable_id, :nameable_type

  belongs_to :nameable, :polymorphic => true
  #belongs_to :user
end
