require "resque_web"

Rails.application.routes.draw do

  resources :keyword_sets, only: [:index, :new, :create, :update, :destroy] do
    resources :keywords, only: :index
  end

  resource :result_weights, only: [:edit, :update]

  root 'keyword_sets#index'

  # For heroku free usage, don't use resque
  # Set ENV to RESQUE_WEB_HTTP_BASIC_AUTH_USER and RESQUE_WEB_HTTP_BASIC_AUTH_PASSWORD
  # for HTTP Basic Authentication
  # mount ResqueWeb::Engine => "/resque_web"
end
