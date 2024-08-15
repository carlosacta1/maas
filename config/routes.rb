Rails.application.routes.draw do
  root 'home#index'
  # Session routes for Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # API routes
  namespace :api do
    namespace :v1 do
      put 'monitoring_requests/assign_users', to: 'monitoring_requests#assign_users'
      resources :services do
        scope module: :services do
          resources :monitoring_requests, only: %i[ index create ]
        end
      end
      resources :users do 
        scope module: :users do
          resources :monitoring_requests, only: %i[ index ]
        end
      end
    end
  end
end
