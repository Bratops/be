class V1::CacheController < V1::BaseController
  include ActionController::Caching
  self.perform_caching = true
  self.cache_store = ActionController::Base.cache_store
end
