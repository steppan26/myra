Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  resources :subscriptions do
    resources :offers, only: %i[new create edit update]
  end
  resources :services, only: %i[index show]
  resources :offers, only: :destroy
<<<<<<< HEAD

  get "/searchService/:query", to: 'subscriptions#display_services'
  get "/searchOffer/:query", to: 'subscriptions#display_offers'
=======
  get "/dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"
  get "/search/:query", to: 'subscriptions#search'
  resources :users, only: %i[edit update]
>>>>>>> 2c3d75f024d48152f4a262e66ef06ec2a95daf21
end
