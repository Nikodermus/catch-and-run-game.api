Rails.application.routes.draw do
	resources :users do
		resources :games
	end	
	
	namespace :sessions do
		post :create
		delete :destroy
	end

	get 'current_user', to: 'users#get_user'	
	get 'my_profile', to: 'users#my_profile'
		
end
