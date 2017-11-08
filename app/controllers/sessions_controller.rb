class SessionsController < ApplicationController

	def create
		user = User.find_by(email: session_params[:email])
		if user and user.tok_auth(session_params[:password])
		  render_success meta: { token: user.get_token, device_token: user.get_device_token}
		else
		  render_error "Couldn't authenticate the user.", status: 404
		end
	end

	def destroy
		if current_user
			#UserTok.find_by(device_token: request.headers["HTTP_APP_TOKEN"]).get_device_token
			render_success
		else
			render_error 'Something went wrong'
		end
	end
	


	private

	def session_params
		params.require(:session).permit(:email, :password)
	end
end
