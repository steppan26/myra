Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :budgets, only: %i[index show new create destroy]
  resources :services, only: %i[index show]
  resources :offers, only: :destroy
  resources :users, only: %i[edit update]

  get "/dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"

  # 'new' form routes
  get "/searchService/:query", to: 'subscriptions#display_services'
  get "/searchOffer/:query", to: 'subscriptions#display_offers'
  get "/newOffer", to: 'subscriptions#display_offer_form'
  get "/subOverview", to: 'subscriptions#subscription_overview'

end
