Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
	
	root 'static_pages#home'

	devise_scope :user do
	  get '/sign_in', to: 'devise/sessions#new'
	  get '/sign_out', to: 'devise/sessions#destroy'
	  get '/sign_up', to: 'devise/registrations#new'
	end
	resources :users, 	 only: 	 [:show, :index] do
		member do
			get :friends, :notifications
		end
	end
	
	resources :posts, 	 except: [:index] do 
		resources :comments, only: 	 [:new, :create, :destroy]
		resources :likes, 	 only: 	 [:create, :destroy, :index]
	end
  resources :friendships,        only: [:create, :destroy, :update]

end
