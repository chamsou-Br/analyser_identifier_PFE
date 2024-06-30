require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mstags
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # config.middleware.insert_before 0, Rack::Cors do
    

    config.i18n.load_path += Dir[config.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :en


    AVAILABLE_LOCALES = %i[en fr es de].freeze
    config.i18n.available_locales = AVAILABLE_LOCALES
    config.i18n.fallbacks = [I18n.default_locale]


    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'  # You can specify specific origins here instead of '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
