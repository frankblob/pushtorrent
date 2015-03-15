get '/user/?' do

	if current_user?
		@user = User.get(session[:user_id])
		@trackers = @user.trackers
		erb :user
	else
		redirect '/login'
	end

end

patch '/user/?' do

	if user = User.get(session[:user_id])
		user.name = params[:user][:name]
		user.save
		flash[:success] = "That's great, #{user.name}. You have added your name successfully."
		redirect '/user'
	else
		redirect '/login'
	end
end
