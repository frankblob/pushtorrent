get '/user/:id/remove/?' do
	if session[:user_id] == params[:id].to_i 
		erb :removeuser
	else
		flash[:warning] = "You need to be logged in to delete your account. Please login and try again."
		redirect '/login'
	end	 
end

post '/user/:id/remove/?' do
	# Works, but really needs refactoring (DB handling of delete process)
	if session[:user_id] == params[:id].to_i && params[:emailconfirm] == User.get(session[:user_id]).email
		User.get(session[:user_id]).user_trackers.each {|ut| ut.delete; tracker = Tracker[id: ut.tracker_id]; if tracker.users.count == 0;   tracker.destroy; end }
		User.get(session[:user_id]).delete	
		session[:user_id] = nil
	else
		flash[:warning] = "It seems the email was not entered correctly. Please try again."
		redirect "/user/#{session[:user_id]}/remove"
	end	
	flash[:info] = "Your user account is now deleted. Entirely. Consider sending me site improvement suggestions before you leave. Thanks!"
	redirect '/'
end