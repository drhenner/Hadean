class Order < ActiveRecord::Base
  belongs_to :user
  state_machine :initial => 'in_progress' do
    
  end
end
