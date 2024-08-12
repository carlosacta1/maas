Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    namespace :v1 do
      resources :service_user_monitors
      resources :services
      resources :users
    end
  end

  # Session routes
  post 'login', to: 'sessions#create'
  put 'refresh', to: 'sessions#update'
  delete 'logout', to: 'sessions#destroy'

  # Auth routes
  get 'verify-token', to: 'auth#verify_token'
end
