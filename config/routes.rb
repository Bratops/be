# == Route Map
#
# Prefix Verb URI Pattern         Controller#Action
#   task GET  /task/:id(.:format) v1/task#show
#   root GET  /                   application#landing
#

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/bebras.tw; ver=1"}) do
    resources :task, only: [:show] do
      member do
        get "sweep" => "task#sweep"
      end
      collection do
        get "list" => "task#list"
      end
    end
  end

  # You can have the root of your site routed with "root"
  root 'application#landing'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
