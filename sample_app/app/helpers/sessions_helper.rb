module SessionsHelper
	# logs in the given user
	def log_in(user)
		session[:user_id] = user.id
	end

	# remembers a user in a presistent session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# forgets a permanent session
	def forget(user)
		user.forget
		cookies.delete(:remember_token)
		cookies.delete(:user_id)
	end

	# returns true if the given user is the current user
	def current_user?(user)
		user == current_user
	end

	# returns the current logged in user (if any)
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: session[:user_id])
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
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

	# redirects to stored location (or to the default)
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# stores the URL trying to be accessed
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

end
