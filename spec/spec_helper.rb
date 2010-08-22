# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require 'rspec'
#require 'rspec/rails'
#require 'generators_spec'

require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)


# Require for machinist
#require File.expand_path(File.dirname(__FILE__) + "/blueprint.rb")
#Dir["#{File.dirname(__FILE__)}/blueprints/*.rb"].each {|f| require f}

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

include Hadean::TruncateHelper
#setup { Sham.reset } 

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  
  # MACHINIST stuff
  config.before(:all)    do 
    Sham.reset(:before_all)
    #trunctate_unseeded
  end
  
  config.before(:each)   do 
    Sham.reset(:before_each) 
  end
  
  #config.use_transactional_fixtures = true
  config.before(:suite) { trunctate_unseeded }
  
  #config.before :suite do
  #  trunctate_unseeded
  #end
  # If you'd prefer not to run each of your examples within a transaction,
  # uncomment the following line.
  # config.use_transactional_examples = false
  
  config.logger = :stdout
  config.include ControllerMacros
end

#Rspec::Runner.configure do |config|
  #config.before(:all) { trunctate_unseeded }
  #config.before(:each) {}
  #config.after(:all) {}
  #config.after(:each) {}
#end