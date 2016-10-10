Rails.application.routes.draw do

  get 'events/new'

  post 'events/create'

  get 'events/show'

  get '/events', to: 'events#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

	root 'events#index'

  get 'users/new'

  post 'users/create'

  get 'users/show'

  get 'events/going'

  resources :users,   only: [:new, :create, :show]
  resources :events,  only: [:new, :create, :show, :index]

end
