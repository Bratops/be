Apipie.configure do |config|
  config.app_name = "Bras Backend API"
  config.copyright = "&copy; 2014 Bebras API"
  config.doc_base_url = "/api-doc"
  config.api_base_url = ""
  config.version_in_url = true
  config.validate = false
  config.markup = Apipie::Markup::Markdown.new
  config.reload_controllers = Rails.env.development?
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "**","*.rb")
  config.api_routes = Rails.application.routes
  config.app_info = "Bebras cross platform API"
  config.languages = ['en']
  config.default_locale = 'en'
  config.authenticate = Proc.new do
     authenticate_or_request_with_http_basic do |username, password|
       username == "_api_dev" && password == "pass_Ward"
    end
  end
end
