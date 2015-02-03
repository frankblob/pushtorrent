get '/login/?' do
	erb :login
end

post '/login/?' do
	redirect '/login' unless user = User.where(email: params[:user][:email]).first
	if BCrypt::Password.new(user.password_digest) == params[:user][:password]
		session[:user_id] = user.id
		flash[:message] = "You are now logged in. Glad to have you back!"
		redirect '/user'
		#env[return_path] (set as attempted path when unauthorized) ? redirect back : '/'
	else
		#session[:user_id] = nil
		flash[:message] = "Your login failed. Please try again."
		redirect '/login'
	end
end

get '/logout/?' do
	session[:user_id] = nil
	flash[:message] = "You are now logged out. Come back another time!"
	redirect '/'
end