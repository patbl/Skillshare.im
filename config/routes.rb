Skillshare::Application.routes.draw do
  resources :users, except: [:new, :create] do
    resources :offers, shallow: true, except: :index do
      resources :messages, only: :create
    end
  end

  root 'offers#index'
  root 'offers#index', as: 'offers'
  get 'map'    => 'users#map'
  get 'offers' => 'offers#index', as: 'offers_atom'

  # authentication
  get 'auth/facebook',   as: 'facebook_auth'
  get 'auth/browser_id', as: 'browser_id_auth'
  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  get 'auth/failure'              => 'sessions#failure'
  get 'sessions'                  => 'sessions#create'
  get 'signin'                    => 'sessions#new',     as: 'signin'
  get 'signout'                   => 'sessions#destroy', as: 'signout'

  # static pages
  get 'about' => 'pages#about'
  get 'faq'   => 'pages#faq'
end
