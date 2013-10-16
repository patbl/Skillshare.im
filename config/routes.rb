Skillshare::Application.routes.draw do
  get "sessions/create"
  get "sessions/destroy"
  root 'pages#show'
end
