class ApplicationController < ActionController::Base
	USERS = {
		admin: {
			name: ENV.fetch("ADMIN_NAME"),
			password: ENV.fetch("ADMIN_PASSWORD"),
		},
		user: {
			name: ENV.fetch("USER_NAME"),
			password: ENV.fetch("USER_PASSWORD"),
		}
	}

	before_action :authenticate

	helper_method :admin?
	def admin?
		@role == :admin
	end

	private
	def authenticate
		authenticate_or_request_with_http_basic do |id, password|
		  @role = USERS.keys.find do |key|
		  	USERS[key][:name] == id && USERS[key][:password] == password
		  end
		  !!@role
		end 
	end	
end
