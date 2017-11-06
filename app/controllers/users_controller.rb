class UsersController < ApplicationController

	before_action :authenticate_user!, only: [:update, :destroy]
	
	def create
		user = User.new(user_params)
		if user.save
			render_success {}
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
			render_success user: current_user.as_json(:except => [:password_digest, :img_path])
		else
			render_error 'No user'
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
