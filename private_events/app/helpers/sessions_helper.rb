module SessionsHelper
	# logs the user in
	def log_in(user)
		session[:user_id] = user.id
	end

	# returns true if the given user is the current user
	def current_user?(user)
		user == current_user
	end

	# returns the current logged in user (if any)
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		else
			nil
		end
	end

	# returns true if user is logged in and false otherwise
	def logged_in?
		!current_user.nil?
	end

	# logs out current user
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
end
