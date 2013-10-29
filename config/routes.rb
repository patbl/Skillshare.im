Skillshare::Application.routes.draw do
  root 'pages#show'

  resources :users do
    resources :proposals
  end

  resources :sessions, only: %i[new create destroy]

  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match 'auth/failure', to: redirect('/'), via: %i[get post]
  match 'signin', to: 'sessions#new', as: 'signin', via: :get
  match 'signout', to: 'sessions#destroy', as: 'signout', via: %i[get post]
  match 'facebook/auth', as: 'facebook_auth', via: :get

end
