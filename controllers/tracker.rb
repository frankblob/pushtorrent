post '/trackers/?' do
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
	if current_user?
		# split logic depending on user type
		user = User.get(params[:user_id])
		timestamp = params[:timestamp]
		if Tracker[keywords: params[:keywords]].nil?
			tracker = Tracker.create(keywords: params[:keywords], timestamp: params[:timestamp])
		else
			tracker = Tracker[keywords: params[:keywords]]
		end
		user.add_user_tracker(tracker: tracker, timestamp: params[:timestamp])
		erb "Tracker added for #{params[:keywords]}.\n#{params}"
	else
		#ask for email and store as user type 0
		erb "We need your email to notify for new torrents - or you can signup to get 5 trackers."
	end

end