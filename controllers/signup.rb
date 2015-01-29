get '/signup/?' do #display signup form
	erb :signup_form
end

post '/signup/?' do #create user
	user = User.new(params[:user])
	if user.save
		redirect to("/user/#{ user.id }") #|| redirect back or:home?
	else 
		redirect '/signup'
	end
end