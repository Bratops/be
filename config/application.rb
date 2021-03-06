require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Be
  class Application < Rails::Application
    config.middleware.insert 0, Rack::Cors do
      allow do
        # regular expressions can be used here
        origins ENV["host_front"], ENV["host_dev_front"]
            # /http:\/\/192\.168\.0\.\d{1,3}(:\d+)?/
        resource "*", headers: :any, methods: [:get, :put, :post, :patch, :options, :delete]
      end
    end
    config.autoload_paths += Dir[Rails.root.join("app", "uploaders")]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Taipei"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.session_store = :cookie_store, { key: "_app_session"}
    config.api_only = false
    config.i18n.default_locale = :"zh-TW"
  end
end
