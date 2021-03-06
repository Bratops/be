Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.action_controller.perform_caching = true
  config.cache_classes = false
  config.cache_store = :memory_store
  #config.cache_store.silence!

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  # Don't care if the mailer can't send.
  config.action_mailer.default_url_options = { host: ENV["host_email"] }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "mail.google.com",
    user_name:            Rails.application.secrets.gmail_user,
    password:             Rails.application.secrets.gmail_pass,
    authentication:       "plain",
    enable_starttls_auto: true  }
  Be::Application.config.middleware.use ExceptionNotification::Rack,
    hipchat: {
      api_token: ENV["hipchat_token"],
      room_name: ENV["hipchat_room"],
      from: ENV["hipchat_from"],
      api_version: "v2",
      notify: true,
      color: "red",
      message_template: ->(ex) {
        bk = ex.backtrace[1].split(":")
        bki = bk[1].to_i
        ek = File.read(bk[0]).lines[(bki-3)..(bki+1)].join("<br>").gsub(" ", "&nbsp;")
        code = "<br>code: <br>#{ek}<br>"
        bks = ex.backtrace[0..5].reject{|b| b.include? "rbenv"}
        bks = bks.join("<br>").sub(/^.*(app)/, "")
        heading = "DevException: <#{ex.class}>: #{ex.message}"
        bkt = "on: <br>#{bks}"
        heading + code + bkt
      }
    }
end
