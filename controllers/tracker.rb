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
			flash[:info] = "You need to log in before you can add a tracker for '#{params[:keywords]}'."
			# add session storage of keywords and tpyed in email, and ask for password to complete sign up/tracker add?	
			redirect '/login'
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
	