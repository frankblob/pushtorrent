get '/login/?' do #display login form
	erb :login
end

post '/login/?' do #authenticate user and set session
	redirect '/login' unless user = User.where(email: params[:user][:email]).first
	if BCrypt::Password.new(user.password_digest) == params[:user][:password]
		session[:user_id] = user.id
		redirect "/user/#{session[:user_id]}"
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