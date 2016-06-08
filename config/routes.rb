require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  root 'events#index'

  namespace :apis, defaults: { format: :json } do
    api_constraint = ApiConstraints.new(version: 1, default: true)
    scope module: :v1, constraints: api_constraint do
      devise_scope :user do
        post '/login'    => 'sessions#create'
        delete '/logout' => 'sessions#destroy'
      end

      resources :events
      resources :users
    end
  end

  resources :users, only: [:index]
end
