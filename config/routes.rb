Skillshare::Application.routes.draw do
  root 'pages#show'

  resources :users do
    resources :proposals, shallow: true do
      resources :messages
    end
  end
  match 'proposals', to: 'proposals#filter', via: %i[get post]

  resources :sessions, only: %i[new create destroy]

  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match 'auth/failure', to: redirect('/'), via: %i[get post]
  match 'signin', to: 'sessions#new', as: 'signin', via: %i[get post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: %i[get post]
end
