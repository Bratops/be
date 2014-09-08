api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  scope module: :dashboards, format: false do

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
    end

    namespace :teacher do
    end

    namespace :student do
    end

    namespace :user do
    end
  end
end
