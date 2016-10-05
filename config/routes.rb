Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
  	authenticated :user do
  		root "users#index"
  	end

  	unauthenticated do
  		root "devise/sessions#new"
  	end
  end
  
  resources :users, only: [:index, :show]
  resources :posts
  resources :comments
  resources :friendships
end
