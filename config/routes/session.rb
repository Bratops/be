devise_for :users, controllers: {
  sessions:  "v1/user/session",
  passwords:  "v1/user/password",
  registrations: "v1/user/registration",
  omniauth_callbacks: "v1/user/omniauth_callbacks"
}, skip: [:sessions, :registrations, :passwords]
api_version(module: "V1", header: {name: "Accept", value: "application/bebras.tw; ver=1"}) do
  devise_scope :user do
    #resources :omniauth_callbacks
    #match "/auth/:provider", to: "omniauth_callbacks#passthru", via: [:get, :post], as: :user_omniauth_authorize
    #match "/auth/:provider/callback", to: nil, via: [:get, :post], as: :user_omniauth_callback
    get "/session/role" => "user/session#role"
    get "/session"     => "user/session#show"
    post "/session"     => "user/session#create"
    delete "/session"   => "user/session#destroy"
    post "/user"        => "user/registration#create"
    delete "/user"      => "user/registration#destroy"
    resource :password, only: [] do
      get "/edit"      => "user/password#edit", as: :edit_user
      post "/forget"   => "user/password#request_link"
      put "/reset"     => "user/password#reset"
      get "/mail_test" => "user/password#mail_test"
    end
  end
end
