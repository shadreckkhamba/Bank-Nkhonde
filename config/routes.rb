Rails.application.routes.draw do
  resources :users
  resources :groups do
    resources :memberships, only: [:create, :destroy]
  end
  resources :contributions, only: [:create, :index]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'groups/:join_code', to: 'groups#show', as: 'group_by_join_code'
end