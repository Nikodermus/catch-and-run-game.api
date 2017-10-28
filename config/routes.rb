Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :users do
		resources :game
	end	
	
	namespace :sessions do
		post :create
		delete :destroy
	end



	
	
end
