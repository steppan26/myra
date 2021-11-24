Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :services, only: %i[index show]
  resources :offers, only: :destroy
  get "/dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"
  get "/search/:query", to: 'subscriptions#search'
  resources :users, only: %i[edit update]
end
