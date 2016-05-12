Rails.application.routes.draw do
  root 'home#index'

  namespace :apis, defaults: { format: :json } do
    namespace :v1 do
      # Routes for events controller
      resources :events do
      end
    end
  end
end
