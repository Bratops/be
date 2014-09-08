class V1::CacheController < V1::BaseController
  include ActionController::Caching
  self.perform_caching = true
  self.cache_store = ActionController::Base.cache_store

  def cache_with key, opts={}
    lk = "#{controller_name}.#{action_name}.#{key}"
    puts lk
    Rails.cache.fetch lk, opts do
      yield
    end
  end
end
