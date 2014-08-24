source "https://rubygems.org"

gem "rails", "4.1.5"
gem "rails-api", "0.2.1"
gem "figaro", "~> 0.7.0"
gem "active_model_serializers", "0.8.1"
gem "versionist", "~> 1.3.0"

# notify
gem "hipchat", "~> 1.3.0"
gem "exception_notification", git: "https://github.com/smartinez87/exception_notification.git", ref: "f5dd6ebe508fe008a999790de348a9d69f073728"

# auth
gem "devise", "~> 3.2.0"

# model
gem "migrant", "~> 1.5.0"
gem "counter_culture", "~> 0.1.23"
gem "seedbank", "~> 0.3.0"
# To use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.1.2"

# doc
gem "apipie-rails", git: "https://github.com/Apipie/apipie-rails.git", ref: "7e8402c99d1ac726e2c92d16dcc33a3fe1019255"
gem "maruku" # for apipie-rails

# Use unicorn as the app server
group :production do
  gem "pg", "~> 0.17.1"
  gem "unicorn", "~> 4.8.3"
end

group :development do
  gem "spring"
  gem "kramdown"
  gem "annotate", "~> 2.6.5"
end

group :development, :test do
  gem "sqlite3"

  gem "capistrano", "~> 3.2.1"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "capistrano3-nginx_unicorn"

  gem "pry", "~> 0.10.1"
  gem "pry-rails", "~> 0.3.2"
  gem "pry-doc", "~> 0.6.0"
  gem "pry-git", "~> 0.2.3"
  gem "pry-stack_explorer", "~> 0.4.9"
  gem "pry-clipboard"
  gem "pry-remote", ">= 0.1.8"
  gem "pry-byebug", "~> 1.3.3"
  gem "hirb", "~> 0.7.2"
  gem "coolline", ">= 0.4.4"
  gem "awesome_print", "~> 1.2"
  gem "railties", ">= 3.0", "< 5.0"
  gem "better_errors", "~> 1.1.0"
  gem "binding_of_caller", "~> 0.7.2"
  gem "meta_request", "~> 0.3.4"
end
