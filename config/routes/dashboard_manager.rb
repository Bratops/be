api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  scope module: :dashboards, format: false do
    namespace :admin do
      resource :users, only: [] do
        get "/" => "users#index"
      end
      resources :user, only: [] do
        collection do
          get "list/:attr" => "user#list"
        end
      end
      resources :menu, only: [] do
        collection do
          post "" => "menu#update"
        end
      end
    end

    namespace :manager do
      resources :files, only: [:destroy, :index] do
        collection do
          get "upload"    => "files#upload_info"
          post "upload"   => "files#upload"
        end
      end

      resources :msgs, only: [:index, :create, :update, :destroy]

      resources :edus, except: [:new, :edit] do
        member do
          post "details" => "edus#details"
        end
        collection do
          get "list" => "edus#list"
        end
      end

      resource :users, only: [] do
        get "list/:kind" => "users#list"
        post "approve_teacher" => "users#approve"
      end

      resources :surveys, except: [:new, :edit] do
        collection do
          get "list" => "surveys#list"
        end
      end

      resources :tasks, except: [:new, :edit] do
        member do
          get "sweep" => "tasks#sweep"
        end
        collection do
          get "list" => "tasks#list"
        end
      end

      resources :contests, except: [:new, :edit] do
        collection do
          get "tasks" => "contests#tasks"
        end
      end
    end
  end
end
