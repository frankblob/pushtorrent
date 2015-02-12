get '/user/:id/remove/?' do
	if current_user? == params[:id] 
		erb :removeuser
	else
		flash[:warning] = "You need to be logged in to delete your account. Please login and try again."
		redirect '/login'
	end	 
end

post '/user/:id/remove/?' do
	if current_user? == params[:id] && params[:emailconfirm] == User.get(session[:user_id]).email
		User[id: User.get(session[:user_id]).delete	
		# to-do:
		# check and delete associated usertrackers along with potential zero-user trackers.
		session[:user_id] = nil
	else
		flash[:warning] = "It seems the email was not entered correctly. Please try again."
		redirect '/user/#{session[:user_id]}/remove'
	end	
	flash[:info] = "Your user account is now deleted. Entirely. Consider sending me site improvement suggestions before you leave. Thanks!"
	redirect '/'
end