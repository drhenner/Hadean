module ActiveMerchant
  module Utils
    def get_payment_gateway
      gateway = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
        :login => CIM_LOGIN_ID,
        :password => CIM_TRANSACTION_KEY,
        :test => ENV['RAILS_ENV'] != 'production' ? true : false
      )
      if not gateway
        raise AuthenticationFailed, 'Authentication with CIM Gateway could not be completed.'
      end
      return gateway
    end
  end
end