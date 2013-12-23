Skillshare::Application.routes.draw do
  resources :users, except: %i[new create] do
    resources :offers, shallow: true, except: :index do
      resources :messages, only: :create
    end
  end

  root 'offers#index'
  root 'offers#index', as: 'offers'
  get 'map'       => 'users#map'
  get 'offers' => 'offers#index', as: 'offers_atom'

  # authentication
  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure'            => 'sessions#failure'
  get 'sessions'                => 'sessions#create'
  get 'signin'                  => 'sessions#new',     as: 'signin'
  get 'signout'                 => 'sessions#destroy', as: 'signout'

  # static pages
  get 'about' => 'pages#about'
  get 'faq'   => 'pages#faq'
end
