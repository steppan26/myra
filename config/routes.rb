Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :services, only: %i[index show]
  resources :offers, only: :destroy

  get "/searchService/:query", to: 'subscriptions#display_services'
  get "/searchOffer/:query", to: 'subscriptions#display_offers'
end
