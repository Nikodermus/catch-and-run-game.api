class UsersController < ApplicationController

	before_action :authenticate_user!, only: [:update, :destroy]

	def create
		user = User.new(user_params)
		if user.save
			user.save
			render_success email: => user[:email]
		else
			render_error message: => 'Wrong credentials, try again'
		end
		
	end

	def show
		user = User.find_by email: user_params[:email]
		if user
			render_success user
		else
			render_error message: => 'Oops! User not found'
	end

	def update
		user = User.find_by email: user_params[:email]
		if user
			user.update(user_params)
			render_success user
		else
			render_error message: => 'Oops! User not found'
		end
	end

	def destroy
		user = User.find_by email: user_params[:email]
		if user
			user.delete
			render_success 
		else
			render_error message: => 'User couldn\'t be delete'
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password_digest)
	end

	def authenticate_user!
		current_user 
	end
end
