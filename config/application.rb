require File.expand_path('../boot', __FILE__)
#require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
#require "devise"
Bundler.require(*Rails.groups)


module MyConference
  class Application < Rails::Application

  	# config.serve_static_files = true
    # config.api_only = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
