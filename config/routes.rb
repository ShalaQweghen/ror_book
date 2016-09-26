Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
  	authenticated :user do
  		root "users#show"
  	end

  	unauthenticated do
  		root "devise/sessions#new"
  	end
  end
  
  resources :posts
  resources :comments
end
