get '/login/?' do
	erb :login
end

post '/login/?' do
	redirect '/login' unless user = User.where(email: params[:user][:email]).first
	if BCrypt::Password.new(user.password_digest) == params[:user][:password]
		session[:user_id] = user.id
		flash[:loginsucces] = "You have logged in to Torrent Watch. Glad to have you back!"
		redirect "/user"
		#env[return_path] (set as attempted path when unauthorized) ? redirect back : '/'
	else
		#session[:user_id] = nil
		redirect '/login'
	end
end

get '/logout/?' do
	session[:user_id] = nil
	redirect '/'
end