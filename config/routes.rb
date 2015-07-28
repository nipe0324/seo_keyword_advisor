require "resque_web"

Rails.application.routes.draw do

  resources :keyword_sets, only: [:index, :new, :create, :update, :destroy] do
    resources :keywords, only: :index
  end

  root 'keyword_sets#index'

  # Set ENV to RESQUE_WEB_HTTP_BASIC_AUTH_USER and RESQUE_WEB_HTTP_BASIC_AUTH_PASSWORD
  # for HTTP Basic Authentication
  mount ResqueWeb::Engine => "/resque_web"
end
