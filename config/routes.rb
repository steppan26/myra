
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
  get "infos", to: "pages#infos"

  # 'new' form routes
  get "/searchService/:query", to: 'subscriptions#display_services'
  get "/searchOffer/:query", to: 'subscriptions#display_offers'
  get "/newOffer", to: 'subscriptions#display_offer_form'
  get "/subOverview", to: 'subscriptions#subscription_overview'
  get "/updateBudgets/:id", to: 'budgets#update'
  get "/updateBudgetsInfo/:id", to: 'budgets#updateInfo'
  get "/updateBudgetsHeader/:id", to: 'budgets#update_show_header'
  delete "/removeSubscriptionFromBudget/:subscription_id/:budget_id", to: 'budgets#destroy_budget_item', as: :destroy_budget_item

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
