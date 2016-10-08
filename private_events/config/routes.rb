Rails.application.routes.draw do

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

	root 'users#new'

  get 'users/new'

  post 'users/create'

  get 'users/show'

  resources :users, only: [:new, :create, :show]

end
