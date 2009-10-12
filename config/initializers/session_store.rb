# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hadean_session',
  :secret      => '10ff9dd2aacf0bc71ed2741282ff1e8962fda879298b0604c3adc960d68b1744a319ecf9d7b9f8e013ac4c085ca854567fd308926635d2e5d8401688a36a7e2b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
