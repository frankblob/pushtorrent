get '/user/?' do

	if current_user?
		@user = User.get(session[:user_id])
		@trackers = @user.trackers
		erb :user
	else
		redirect '/login'
	end

end
