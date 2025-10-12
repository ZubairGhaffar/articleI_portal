# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  get "profile", to: "users#profile"
  get "users/:id/profile", to: "users#public_profile", as: :user_profile





  resources :articles do
    resources :comments, only: [ :create, :destroy ]
  end






   resources :users, only: [] do
    member do
      get :public_profile
    end
    resources :subscriptions, only: [ :create, :destroy ]
  end

  get "/my_subscriptions", to: "subscriptions#index", as: "my_subscriptions"

  get "my_articles", to: "articles#my_articles"
  root "articles#index"
end
