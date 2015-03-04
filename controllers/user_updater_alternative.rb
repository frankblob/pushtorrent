# simple updater, based on going thtrough each user's trackers.

def find_updates
	users = User.all # learn and use eager loading
	users.each do |user|
		@user_updates = []
		compare = user.user_trackers
		compare.each do |tracker| 
			if tracker.timestamp < Tracker[tracker.tracker_id].timestamp
				@user_updates << Tracker[tracker.tracker_id].keywords
				# Next line should be rolled-back if mailing the user the upodates fails, so to be included in next update process
				tracker.timestamp = Tracker[tracker.tracker_id].timestamp
			end
		end
		if !@user_updates.empty?
			new_torrents(user.email, @user_updates)
			# Develop retry mechanism (three times?) and reporting/error handling 
		end
	end
end