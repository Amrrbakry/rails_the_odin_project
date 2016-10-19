Rails.application.routes.draw do
	
	namespace :api, defaults: { format: 'json' } do
		namespace :v1 do
			resources :kittens
		end
	end

	root 'kittens#index'

	resources :kittens
end
