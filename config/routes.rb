require 'api_constraints'

Rails.application.routes.draw do
  root 'home#index'

  namespace :apis, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :events
    end
  end
end
