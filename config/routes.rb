Skillshare::Application.routes.draw do
  resources :users, except: [:new, :create], path: "community" do
    with_options except: :index, shallow: true, controller: "proposals" do |options|
      options.resources :wanteds, type: "Wanted" do
        resources :messages, only: :create
      end
      options.resources :offers, type: "Offer" do
        resources :messages, only: :create
      end
    end
  end

  root 'proposals#home'
  root 'proposals#home', as: 'proposals'
  get 'proposals' => 'proposals#index', type: "Proposal", as: 'proposals_atom'

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

  get 'statistics' => 'statistics#index'
  get 'unsubscribe/:secure_key' => 'subscriptions#unsubscribe', as: 'unsubscribe'

  # static pages
  get ':action' => 'pages#:action'
end
