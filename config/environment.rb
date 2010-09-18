# Load the rails application
require File.expand_path('../application', __FILE__)

# Load custom config file for current environment
raw_config = File.read("config/config.yml")
HADEAN_CONFIG = YAML.load(raw_config)[Rails.env]

CIM_LOGIN_ID = HADEAN_CONFIG['paypal']['login']
CIM_TRANSACTION_KEY = HADEAN_CONFIG['paypal']['password']

#Paperclip.options[:command_path] = "/Users/davidhenner/ImageMagick-6.5.9/bin"
Paperclip.options[:command_path] = "/usr/local/bin"

# Initialize the rails application
Hadean::Application.initialize!
