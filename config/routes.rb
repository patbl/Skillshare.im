Skillshare::Application.routes.draw do
  resources :users, except: [:new, :create] do
    resources :wanteds, shallow: true, except: :index, controller: "proposals", type: "Wanted" do
      resources :messages, only: :create
    end
    resources :offers, shallow: true, except: :index, controller: "proposals", type: "Offer" do
      resources :messages, only: :create
    end
  end

  root 'proposals#index', type: "Proposal"
  root 'proposals#index', type: "Proposal", as: 'proposals'
  get 'map'    => 'users#map'
  get 'offers' => 'proposals#index', type: "Proposal", as: 'offers_atom'

  get 'offers' => 'proposals#index', type: "Offer"
  get 'wanteds' => 'proposals#index', type: "Wanted"

  # authentication
  get 'auth/facebook',   as: 'facebook_auth'
  get 'auth/browser_id', as: 'browser_id_auth'
  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  get 'auth/failure'              => 'sessions#failure'
  get 'sessions'                  => 'sessions#create'
  get 'signin'                    => 'sessions#new',     as: 'sign_in'
  get 'signout'                   => 'sessions#destroy', as: 'sign_out'

  # static pages
  get ':action' => 'static#:action'
end
