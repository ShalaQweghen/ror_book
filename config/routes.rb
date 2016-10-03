Rails.application.routes.draw do
  get 'friendships/new'

  get 'friendships/create'

  get 'friendships/delete'

  devise_for :users

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
end
