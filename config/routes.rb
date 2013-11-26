Skillshare::Application.routes.draw do
  resources :users, except: %i[new create destroy] do
    resources :proposals, shallow: true, except: :index do
      resources :messages, only: :create
    end
  end

  root 'proposals#index'
  root 'proposals#index', as: 'proposals'
  get 'map', to: 'proposals#map'

  # authentication
  resources :sessions, only: %i[new create destroy]
  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match 'auth/failure', to: 'sessions#failure', via: %i[get post]
  match 'signin', to: 'sessions#new', as: 'signin', via: %i[get post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: %i[get post]

  # static pages
  get 'about', to: 'pages#about'
  get 'faq', to: 'pages#faq'
end
