Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :transactions
  resources :contributions
  resources :histories, only: [:index, :create, :destroy, :show]

  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

  get '/register', to: 'authentication#register_form'
  get '/login', to: 'authentication#login_form'
  post '/login', to: 'authentication#login'
  delete '/logout', to: 'authentication#logout'

  resources :groups do
    resources :memberships, only: [:create, :destroy]
  end

  get 'groups/:join_code', to: 'groups#show', as: 'group_by_join_code'
end