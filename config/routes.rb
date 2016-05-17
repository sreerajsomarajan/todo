require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  namespace :apis, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      devise_scope :user do
        post '/login'      => 'sessions#create'
        delete '/logout'   => 'sessions#destroy'
      end

      resources :events
    end
  end
end
