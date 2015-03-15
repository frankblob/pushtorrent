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
		flash[:success] = "You have added your name successfully, #{user.name}. Enjoy!"
		redirect '/user'
	else
		redirect '/login'
	end
end
