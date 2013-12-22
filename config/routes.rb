Skillshare::Application.routes.draw do
  resources :users, except: %i[new create] do
    resources :proposals, shallow: true, except: :index do
      resources :messages, only: :create
    end
  end

  root 'proposals#index'
  root 'proposals#index', as: 'proposals'
  get 'map'       => 'users#map'
  get 'proposals' => 'proposals#index', as: 'proposals_atom'

  # authentication
  match 'auth/:provider/callback' => 'sessions#create', via: %i[get post]
  get 'auth/failure'              => 'sessions#failure'
  get 'sessions'                  => 'sessions#create'
  get 'signin'                    => 'sessions#new',     as: 'signin'
  get 'signout'                   => 'sessions#destroy', as: 'signout'

  # static pages
  get 'about' => 'pages#about'
  get 'faq'   => 'pages#faq'
end
