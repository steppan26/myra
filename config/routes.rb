Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :subscriptions do
    resources :offers, only: [:new, :create, :edit, :update]
  end
  resources :services, only: [:index, :show]
  resources :offers, only: [:destroy]
end
