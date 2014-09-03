devise_for :users, controllers: {
  sessions:  "v1/session",
  passwords:  "v1/password",
  registrations: "v1/registration",
  omniauth_callbacks: "v1/omniauth_callbacks"
}, skip: [:sessions, :registrations, :passwords]
api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  devise_scope :user do
    #resources :omniauth_callbacks
    #match "/auth/:provider", to: "omniauth_callbacks#passthru", via: [:get, :post], as: :user_omniauth_authorize
    #match "/auth/:provider/callback", to: nil, via: [:get, :post], as: :user_omniauth_callback
    get "/session/role" => "session#role"
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
end
