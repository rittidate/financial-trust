Rails.application.routes.draw do
  root "dashboards#show"
  resource :dashboard, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resources :accounts, only: [:update, :show]
  resources :accounts, only: [:update, :show]

  resources :deposits, only: [:new, :create]

  namespace :admin do
    resources :accounts, only: [:new, :create, :index, :show] do
      post :payout_interest, on: :collection
    end
    resources :transfers, only: [:new, :create]
    resources :deposits, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end
end
