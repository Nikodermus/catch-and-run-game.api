class ApplicationController < ActionController::API

	before_action :check_tokens	

  
	def current_user
	  @current_user ||= User.validate_access(token: request.headers["HTTP_APP_TOKEN"])
	end
  
	def user_signed_in?
	  !current_user.nil?
	end
  
	def current_token
	  current_user ? current_user.get_token : nil
	end
  
	def current_device_token
	  current_user ? current_user.get_device_token : nil
	end
  
	# After 15 minutes, the next user request will refresh the tokens.
	# it is necessary to send the tokens to the front-end again
  
	def tokens_refreshed?
	  current_user and current_user.refreshed?
	end

	def render_json(object, options = {})
		status = options.delete(:status)
		render json: { data: object}.merge(options) , status: status ? status : 200 and return if !meta
		render json: { data: object}.merge(options).merge(meta) , status: status ? status : 200 and return if meta

	end

	def render_success(options = {})
		render json: { success: true }.merge(options), status: status ? status : 200 and return if !meta
		render json: { success: true }.merge(options).merge(meta) , status: status ? status : 200 and return if meta
	end

	def render_error(message, options = {})
		status = options.delete(:status)
		render json: { success: false , message: message}.merge(options), status: status ? status : 500 and return if !meta
		render json: { success: false , message: message}.merge(options).merge(meta), status: status ? status : 500 and return if meta
	end

	def meta
		@meta 
	end

	def set_meta(meta = {})
		@meta = meta
	end

	private

	def check_tokens
		set_meta(token: current_user.get_token, device_token: current_user.get_device_token) if tokens_refreshed?
	end
end
