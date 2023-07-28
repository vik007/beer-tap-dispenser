Rails.application.routes.draw do
  devise_for :admin_users

  resources :dispensers

  root 'dispensers#index'

  namespace :api do
    namespace :v1 do
      resources :dispense_events, only: [] do
        collection do
          post :open
          post :close
        end
      end
    end
  end
end
