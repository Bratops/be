api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  scope module: :dashboards, format: false do

    resources :msgs, only: [:index]

    resources :dashboard, only: [] do
      collection do
        get "menu" => "dashboard#menu"
      end
    end

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

      resources :msgs, only: [:index, :create, :update, :destroy] do
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

    namespace :teacher do
      resources :ugroups, except: [:edit, :new] do
        member do
          post "enroll" => "ugroups#enroll"
          get "enrollments" => "ugroups#enrolls"
          post "enrollments" => "ugroups#del_enrolls"
        end
      end
    end

    namespace :student do
    end

    namespace :user do
      resources :ugroups, only: [] do
        collection do
          post "join" => "ugroups#join"
        end
      end

      resources :surveys, only: [] do
        collection do
          get "current" => "surveys#current"
          post "submit" => "surveys#submit"
        end
      end

      resources :contests, only: [:index] do
        collection do
          post "current" => "contests#current"
          post "current/submit" => "contests#submit"
        end
      end
    end
  end
end
