post '/trackers/?' do

	if current_user?
		# split logic depending on user type [0,1 or 2]
		user = User.get(session[:user_id])
		tracker = Tracker.create_or_select(params[:keywords], params[:timestamp])
		usertracker = user.add_user_tracker(tracker: tracker, timestamp: params[:timestamp])
		erb "Tracker added for <strong>\"#{params[:keywords]}\" released after #{params[:timestamp]}.\n#{params}\n{session}"
		#flash[:addtrackersucces] = "The tracker for '#{params[:keywords]}' has been added. We will notify you once new downloads are available."
		#redirect back	
	else
		#ask for email and store as user type 0
		erb "Now we just need your email, so we can notify you.\n\nRegistered users have five trackers. Sign up and get five trackers."
	end

end

	# redirect_back or redirect "/trackers"?
#if current_user does not exists:

#if email does not exist
# display email + torrent notification and settings

#	user = User.new(params[:email])
#	user.save
#	tracker = Tracker.new(params[:keywords])
#	tracker.save #check routine for existing
# usertracker = UserTracker.new(user_id: user.id, tracker_id: tracker.id)
# usertracker.save
#	redirect to("/user/#{ user.id }") #|| redirect back or:home?

#if email does exist, with user_type = 0
#display current tracker, offer to replace and to signup

#if email does exist, with user_type = 1 || 2
#display login page

#if current_user exists:
#add and display added + highlighted tracker in user's tracker list
#Tracker added for Equalizer 2014. {"user_id"=>"1", "keywords"=>"Equalizer 2014"} 