Rails.application.routes.draw do
  # root 'welcome#index'

  namespace :apis, defaults: { format: :json } do
    scope module: :v1 do
      # Routes for events controller
      resources :events do
      end
    end
  end
end
