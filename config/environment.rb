# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hadean::Application.initialize!

# Load custom config file for current environment
raw_config = File.read("config/config.yml")
HADEAN_CONFIG = YAML.load(raw_config)[RAILS_ENV]

Paperclip.options[:command_path] = "/Users/davidhenner/ImageMagick-6.6.3/bin"
