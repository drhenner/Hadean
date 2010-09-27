Hadean::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  
  
  
  #config.cache_store = :dalli_store
  #config.cache_store = :mem_cache_store, "localhost" #'localhost:11211'
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  
  
  config.after_initialize do
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::DatePicker)
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::FuturePicker)
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::YearPicker)

    ActiveMerchant::Billing::Base.mode = :test
    #::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    #  :login      => HADEAN_CONFIG['paypal']['login'],
    #  :password   => HADEAN_CONFIG['paypal']['password'],
    #  :signature  => HADEAN_CONFIG['paypal']['signature']
    #)
    
    ::GATEWAY = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login    => HADEAN_CONFIG['authnet']['login'],
      :password => HADEAN_CONFIG['authnet']['password'],
      :test     => true
    )
    
    #::GATEWAY = ActiveMerchant::Billing::BraintreeGateway.new(
    #  :login     => HADEAN_CONFIG['braintree']['login'],
    #  :password  => HADEAN_CONFIG['braintree']['password']
    #)
  end
end
