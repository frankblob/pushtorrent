get '/signup/?' do
	erb :signup_form
end

post '/signup/?' do
	
	if /.+@.+\..+/i.match(params[:user][:email]).nil?
		#flash[emailinvalid] = 'The email address you entered seems to be invalid. Please try again.'
		redirect '/signup'
	else
		user = User.new(params[:user])
		if user.save
			session[:user_id] = user.id
			redirect '/user'
		else 
			redirect '/signup'
		end
	end

end