Rails.application.routes.draw do
  root "dashboards#show"
  resource :dashboard, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resources :accounts, only: [:update]
  resources :transfers, only: [:create]

  namespace :admin do
    resources :accounts, only: [:new, :create]
  end
end
