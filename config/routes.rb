Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :services, only: %i[index show]
  resources :offers, only: :destroy
  resources :users, only: %i[edit update]

  get "/searchService/:query", to: 'subscriptions#display_services'
  get "/searchOffer/:query", to: 'subscriptions#display_offers'
  get "/dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"

end
