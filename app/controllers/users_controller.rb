class UsersController < ApplicationController

	before_action :authenticate_user!, only: [:update, :destroy]
	
	def create
		user = User.new(user_params)
		if user.save
			user.tok_auth(user_params[:password])
			render_success meta: {token: user.get_token, device_token: user.get_device_token}
		else
			render_error user.errors.full_messages
		end
	end

	
	def show
		user = User.find_by email: user_params[:email]
		if user
			render_success user
		else
			render_error 'Oops! User not found' 
		end
	end

	def update
		user = User.find_by email: user_params[:email]
		if user
			user.update(user_params)
			render_success user
		else
			render_error 'Oops! User not found' 
		end
	end

	def destroy
		user = User.find_by email: user_params[:email]
		if user
			user.delete
			render_success 
		else
			render_error "User couldn't be delete" 
		end
	end

	def get_user
		if current_user
			user = current_user
			user.create_tok
			token = user.get_token
			render_success user: user.as_json(:except => [:password_digest, :img_path]), meta: {
				token: token
			}
		else
			render_error 'No user'
		end
	end

	def my_profile
		if current_user
			user = current_user
			latest_games = user.games.order(created_at: :desc).first(10)
			best_games =  user.games.order(score: :desc, duration: :asc).first(10)
			render_success user: user.as_json(:except => [:password_digest]), latest_games: latest_games.as_json, best_games: best_games.as_json
		else
			render_error "User isn't logged in!"
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation,:name, :nickname)
	end

	def authenticate_user!
		current_user 
	end
end
