Skillshare::Application.routes.draw do
  resources :users do
    resources :proposals, shallow: true do
      resources :messages # only: %i[new create]
    end
  end
  match 'proposals', to: 'proposals#filter', via: %i[get post]

  match 'map', to: 'proposals#map', via: %i[get]

  resources :sessions, only: %i[new create destroy]

  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match 'auth/failure', to: 'sessions#failure', via: %i[get post]
  match 'signin', to: 'sessions#new', as: 'signin', via: %i[get post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: %i[get post]

  root 'pages#home'
  get 'about', to: 'pages#about', as: 'about'
end
