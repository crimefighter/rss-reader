# Be sure to restart your server when you modify this file.

# TODO change session settings!
# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_takeoff_session',
  :secret      => '1c7ceaca94058f5aa7a949220197fc468ade678c7d97cde2ea95ee348fffaae9c8abbe0821893d7f306463dba037fbbb8c88e983d271f76abeba07aa8c474f0b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
