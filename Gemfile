source "https://rubygems.org"

gem "rails", "4.1.5"
gem "rails-api", "0.2.1"
gem "rack-cors", require: "rack/cors"
gem "figaro", git: "https://github.com/laserlemon/figaro.git", ref: "9f54872dfc1a972b4a971211706272f0f38495f4"
gem "active_model_serializers", "0.8.2"
gem "versionist", "~> 1.3.0"

# notify
gem "hipchat", "~> 1.3.0"
gem "exception_notification", git: "https://github.com/smartinez87/exception_notification.git", ref: "f5dd6ebe508fe008a999790de348a9d69f073728"

# mailer
gem "slim-rails"

# auth
gem "devise", "~> 3.2.0"
gem "cancan", "~> 1.6.10"
gem "rolify", "~> 3.4.1"
gem "omniauth", "~> 1.2.2"
gem "omniauth-facebook", "~> 2.0.0"
gem "omniauth-oauth2", "~> 1.2.0"
gem "omniauth-google-oauth2", git: "https://github.com/zquestz/omniauth-google-oauth2", ref: "a40a748be080cd3a83808ef98afcbf590d7ffbba"

# model
gem "pg", "~> 0.17.1"
gem "migrant", "~> 1.5.0"
gem "counter_culture", "~> 0.1.23"
gem "seedbank", "~> 0.3.0"
gem "faker", "~> 1.4.3"
gem "awesome_nested_set", "~> 3.0.1"
gem "yaml_db", "~> 0.2.3"
gem "will_paginate", "~> 3.0"
gem "acts-as-taggable-on", "~> 3.4.1"
gem "acts_as_votable", "~> 0.10.0"
gem "carrierwave", "~> 0.10.0"
# To use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.1.2"

# doc
gem "apipie-rails", git: "https://github.com/Apipie/apipie-rails.git", ref: "7e8402c99d1ac726e2c92d16dcc33a3fe1019255"
gem "maruku" # for apipie-rails

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

# Use unicorn as the app server
group :production do
  gem "unicorn", "~> 4.8.3"
end

group :development do
  gem "spring"
  gem "kramdown"
  gem "annotate", "~> 2.6.5"
end

group :development, :test do
  gem "capistrano", "~> 3.2.1"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "capistrano3-nginx_unicorn"
  gem "capistrano-db-tasks", require: false

  gem "railties", ">= 3.0", "< 5.0"
  gem "better_errors", "~> 1.1.0"
  gem "binding_of_caller", "~> 0.7.2"
  gem "meta_request", "~> 0.3.4"
end

