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
      resources :msgs, only: [:index, :create, :update, :destroy]
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
    end
  end
end
