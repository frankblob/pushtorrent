get '/signup/?' do
	erb :signup_form
end

post '/signup/?' do
	user = User.new(params[:user])
	if user.save
		session[:user_id] = user.id
		redirect '/user'
	else 
		redirect '/signup'
	end
end