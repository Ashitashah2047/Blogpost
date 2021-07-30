Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :posts do
    resources :comments
  end

  root to: 'pages#home'
  get 'pages/location'
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

  resources :searches
  
end
