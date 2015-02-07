post '/trackers/?' do

	if current_user?
		# split logic depending on user type [0,1 or 2]
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
	else
		#offer login or ask new user for email and create user type 0
		erb "Now we just need your email, so we can notify you. (Set monthly [x], weekly or daily ) \n\nRegistered users have five trackers. Sign up and get five trackers."
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
	