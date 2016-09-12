require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'rails_po'

module Dummy
  class Application < Rails::Application
    config.paths.add 'page_objects', eager_load: true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

