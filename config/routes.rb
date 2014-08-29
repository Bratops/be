# == Route Map
#
#                 Prefix Verb   URI Pattern                                         Controller#Action
# apipie_apipie_checksum GET    /api-doc/apipie_checksum(.:format)                  apipie/apipies#apipie_checksum {:format=>"json"}
#          apipie_apipie GET    /api-doc(/:version)(/:resource)(/:method)(.:format) apipie/apipies#index {:version=>/[^\/]+/, :resource=>/[^\/]+/, :method=>/[^\/]+/}
#            group_index GET    /group(.:format)                                    v1/group#index
#                        POST   /group(.:format)                                    v1/group#create
#              new_group GET    /group/new(.:format)                                v1/group#new
#             edit_group GET    /group/:id/edit(.:format)                           v1/group#edit
#                  group GET    /group/:id(.:format)                                v1/group#show
#                        PATCH  /group/:id(.:format)                                v1/group#update
#                        PUT    /group/:id(.:format)                                v1/group#update
#                        DELETE /group/:id(.:format)                                v1/group#destroy
#                session POST   /session(.:format)                                  v1/session#create
#                        DELETE /session(.:format)                                  v1/session#destroy
#                   user POST   /user(.:format)                                     v1/registration#create
#                        DELETE /user(.:format)                                     v1/registration#destroy
#             sweep_task GET    /task/:id/sweep(.:format)                           v1/task#sweep
#        list_task_index GET    /task/list(.:format)                                v1/task#list
#                   task GET    /task/:id(.:format)                                 v1/task#show
#                   root GET    /                                                   application#landing
#

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:  "v1/session",
    passwords:  "v1/password",
    registrations: "v1/registration"
  }, skip: [:sessions, :registrations, :passwords]
  apipie
  # The priority is based upon order of creation: first created -> highest priority.
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/bebras.tw; ver=1"}) do
    resources :group, only: [] do
      collection do
        get "publist/:res" => "group#publist"
      end
    end
    devise_scope :user do
      post "/session" => "session#create"
      delete "/session" => "session#destroy"
      post "/user" => "registration#create"
      delete "/user" => "registration#destroy"
      resource :password, only: [] do
        get "/edit" => "password#edit", as: :edit_user
        post "/forget" => "password#request_link"
        put "/reset" => "password#reset"
        get "/mail_test" => "password#mail_test"
      end
    end
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
