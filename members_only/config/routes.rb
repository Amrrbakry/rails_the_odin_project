Rails.application.routes.draw do
  
	root 'posts#index'

  get 'posts/new'
  post 'posts/create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts

end
