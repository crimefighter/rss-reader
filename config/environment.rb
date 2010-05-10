require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  
  config.gem 'authlogic'
  config.gem 'authlogic-oid', :lib => 'authlogic_openid'
  config.gem 'haml'
  config.gem 'formtastic'
  config.gem 'feed-normalizer'
  config.gem 'damog-feedbag', :lib => 'feedbag'
  config.gem 'hpricot'

  config.gem 'texticle'

  # TODO set up timezone
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC' 

  # TODO specify default locale
  config.i18n.default_locale = :en
end

Sass::Plugin.options[:template_location] = RAILS_ROOT + "/app/stylesheets"

SITE_NAME = 'Takeoff'
WEBMASTER_EMAIL = 'me@mydomain.com'
GOOGLE_WEBMASTER_CODES = ['google0000000000000000']
GOOGLE_ANALYTICS_CODE = 'UA-123456'
