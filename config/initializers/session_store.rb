# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lifepack_session',
  :secret      => 'e256731944580a7503931be37c7ee8997f1feeac1aaf4ef4b01dd4ec8d079dd261dee5804edab11d777f6d53b6fdc09b145b704d1c741e224a66254b9195f5b7'
}
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
ActionController::Base.session_store = :active_record_store