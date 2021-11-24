Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :services, only: %i[index show]
  resources :offers, only: :destroy

  get "/search/:query", to: 'subscriptions#search'
end
