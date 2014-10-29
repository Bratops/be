api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  scope module: :dashboards, format: false do

    resources :msgs, only: [:index]

    resources :dashboard, only: [] do
      collection do
        get "menu" => "dashboard#menu"
      end
    end

    namespace :teacher do
      resources :ugroups, except: [:edit, :new] do
        member do
          post "enroll" => "ugroups#enroll"
          get "enrollments" => "ugroups#enrolls"
          post "enrollments" => "ugroups#del_enrolls"
        end
        collection do
          get "clusters" => "ugroups#clusters"
        end
      end

      resources :contests, only: [] do
        collection do
          get "list" => "contests#list"
        end
      end

      resources :conregs, except: [:edit, :new]
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
