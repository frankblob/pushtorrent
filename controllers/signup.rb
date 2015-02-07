get '/signup/?' do
	erb :signup_form
end

post '/signup/?' do
	
	if /.+@.+\..+/i.match(params[:user][:email]).nil?
		flash[:danger] = 'The email address you entered seems to be invalid. Please try again.'
		redirect '/signup'
	elsif User[email: params[:user][:email]].exists?
		flash[:info] = "The email address #{params[:user][:email]} already exists. Please log in with your previously registered password."
		redirect '/login'
	else
		user = User.new(params[:user])
		if user.save
			session[:user_id] = user.id
			flash[:success] = 'You have signed up and everything is ready to go. Enjoy!'		
			redirect '/user'
		else 
			flash[:warning] = 'Your sign up did not succeed. Please try again.'
			redirect '/signup'
		end
	end

end