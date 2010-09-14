class PaymentProfile < ActiveRecord::Base
  include ActiveMerchant::Utils
  
  belongs_to :user
  belongs_to :address
  
  #attr_accessor :address
  attr_accessor :credit_card
  
  before_create :create_payment_profile
  
  def create_payment_profile
    if self.payment_cim_id
      return false
    end
    @gateway = get_payment_gateway
  
    @profile = {:customer_profile_id  => self.user.get_cim_profile,
                :payment_profile      => {:bill_to => self.address,
                                          :payment => {:credit_card => CreditCard.new(self.credit_card)}
                                         }
                }
    response = @gateway.create_customer_payment_profile(@profile)
    if response.success? and response.params['customer_payment_profile_id']
      update_attributes({:payment_cim_id => response.params['customer_payment_profile_id']})
      self.credit_card = {} # clear the credit_card info from memory (for security)
      return true
    end
    #return false
    self.errors.add_to_base('Unable to save CreditCard try again or Please Call for help.')
  end
end
