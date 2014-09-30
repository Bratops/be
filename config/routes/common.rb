apipie
root 'application#landing'

resources :files, only: [] do
  collection do
    get ":code" => "v1/dashboards/manager/files#download"
  end
end

api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  resources :group, only: [] do
    collection do
      get "publist/:res" => "group#publist"
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
