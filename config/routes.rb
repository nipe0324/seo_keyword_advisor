Rails.application.routes.draw do

  resources :keyword_sets, only: [:index, :new, :create] do
    resources :keywords, only: :index
  end

  root 'keyword_sets#index'
end
