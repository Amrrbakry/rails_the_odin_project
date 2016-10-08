Rails.application.routes.draw do

	root 'users#new'

  get 'users/new'

  post 'users/create'

  get 'users/show'

  resources :users, only: [:new, :create, :show]

end
