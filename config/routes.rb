Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :users do
		resource :game
	end	
	
	namespace :sessions do
		post :create
		delete :destroy
	end

	get 'current_user', to: 'users#get_user'




	
	
end
