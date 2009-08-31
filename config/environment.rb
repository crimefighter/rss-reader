RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # TODO set up timezone
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC' 

  # TODO specify default locale
  config.i18n.default_locale = :en
end
