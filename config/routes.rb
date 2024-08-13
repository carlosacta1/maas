Rails.application.routes.draw do
  root 'home#index'
  # Session routes for Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # API routes
  namespace :api do
    namespace :v1 do
      resources :service_user_monitors
      resources :services
      resources :users
    end
  end
end
