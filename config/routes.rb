Rails.application.routes.draw do
  root 'home#index'
  resources :users
  resources :transactions
  resources :contributions
  resources :histories, only: [:index, :create, :destroy, :show]
  post 'auth/login', to: 'authentication#login'

  post '/auth/register', to: 'authentication#register'
  get '/register', to: 'authentication#register_form'

  post 'login', to: 'authentication#login'
  get '/login', to: 'authentication#login_form'

  resources :groups do
    resources :memberships, only: [:create, :destroy]
  end
  delete 'logout', to: 'sessions#destroy'
  get 'groups/:join_code', to: 'groups#show', as: 'group_by_join_code'
  delete '/logout', to: 'authentication#logout'
end