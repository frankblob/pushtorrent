post '/trackers/?' do
	# split logic depending on user type [0,1 or 2]
	if current_user? && User.get(session[:user_id]).type == 1 || 2
		user = User.get(session[:user_id])
		tracker = Tracker.create_or_select(params[:keywords], params[:timestamp])
		if UserTracker[user.id, tracker.id] 
			flash[:info] = "You already have a tracker for '#{params[:keywords]}'. Try again."
			redirect back # Goes to '/' => bad UX. Ajax/JS on-page flash?
		end
		usertracker = user.add_user_tracker(tracker: tracker, timestamp: params[:timestamp])
		if usertracker.save
			flash[:success] = "Tracker added! You will be notified when future '#{params[:keywords]}' torrents are released."
			redirect '/user' # Or Ajax/JS on-page flash?
		else
			flash[:warning] = "Unfortunately, the tracker was not added. Please try again."
			redirect back
		end				
	elsif current_user? && User.get(session[:user_id]).type == 0
		flash[:info] = "Delete your existing tracker first - or sign up (add your password) to get five trackers. It's free."
		redirect '/user'
	else
		if !User[email: params[:email]].nil? && User[email: params[:email]].type == 1 || 2
			flash[:info] = "The email address #{params[:email]} already exists. Please log in to add more trackers."
			redirect '/login'
		elsif !User[email: params[:email]].nil? && User[email: params[:email]].type == 0
			session[:user_id] = User[email: params[:email]].id
			flash[:info] = "Delete your existing tracker first - or sign up (add your password) to get five trackers. It's free."
			redirect '/user'	
		elsif /.+@.+\..+/i.match(params[:email]).nil?
			flash[:danger] = 'The email address you entered seems to be invalid. Please try again.'
			redirect '/signup'
		else
			user = User.new(email: params[:email], type: 0)
			if user.save
				session[:user_id] = user.id
				flash[:success] = "All done. I will notify you once new torrents are available for download. Easy!"
				signup_confirmation(user.email)
				redirect '/user'
			else 
				flash[:warning] = 'Your registration did not succeed. Please try signing up (with passsword) instead.'
				redirect '/signup'
			end
		#if email does exist, with user_type = 0
			#display current tracker, offer to replace and to signup/register:
			#Sign up and get five trackers.
		#else (when email does exist, with user_type = 1 || 2
			#display login page
		#end
	end

end

delete '/trackers/?' do
	if current_user?
		# split logic depending on user type [0,1 or 2]
		user = User.get(session[:user_id])
#		tracker = Tracker.get(params[:tracker_id])
		removedtracker = user.remove_tracker(params[:tracker_id])
		flash[:success] = "The '#{removedtracker.keywords}' tracker has been removed successfully."
		if removedtracker.users.count == 0
			removedtracker.destroy 
		end
		redirect back # '/user', which seems OK?
	else
		redirect back # Logical/theoretical case only?
	end
end		
	