post '/trackers/?' do

	if current_user?
		# split logic depending on user type [0,1 or 2]
		user = User.get(session[:user_id])
		tracker = Tracker.create_or_select(params[:keywords], params[:timestamp])
		if UserTracker[user.id, tracker.id] 
			flash[:message] = "You already have this tracker. Try adding another tracker, instead."
			redirect back
		end
		usertracker = user.add_user_tracker(tracker: tracker, timestamp: params[:timestamp])
		if usertracker.save
			flash[:message] = "The tracker for '#{params[:keywords]}' has been added. We will notify you once new downloads are available."
			redirect '/user'
		else
			flash[:message] = "Unfortunately, the tracker was not added. Please try again."
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
		puts removedtracker.inspect
		if removedtracker.users.count == 0
			removedtracker.destroy 
		end
		redirect back
	else
		redirect back
	end
end		
	