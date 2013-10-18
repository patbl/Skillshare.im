Skillshare::Application.routes.draw do
  root 'pages#show'

  resources :users

  get 'sessions/create'
  get 'sessions/destroy'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
