Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :subscriptions do
    resources :offers, only: [:new, :create, :edit, :update]
  end
  resources :services, only: [:index, :show]
  resources :offers, only: [:destroy]
  get "/dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"
  resources :users, only: [:edit, :update]
end
