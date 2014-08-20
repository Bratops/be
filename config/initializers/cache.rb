if Rails.env.production?
  ActionController::Base.cache_store = :memory_store, { size: 1024.megabytes, :expires_in => 500.minutes }
else
  ActionController::Base.cache_store = :memory_store, { size: 32.megabytes, :expires_in => 5.minutes }
end
ActionController::Base.cache_store.logger = Logger.new("./log/cache.log")
ActionController::Base.cache_store.logger.level = Logger::INFO
