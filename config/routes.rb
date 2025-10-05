Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'

  resources :articles do
    resources :comments, only: [:create, :destroy]
  end

  get '/my_articles', to: 'articles#my_articles', as: 'my_articles'
end