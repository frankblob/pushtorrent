get '/twenty4hruserupdate-second/?' do
	@updated = []
	find_updates
	if !@updated.empty?
		@output = @updated.group_by {|x| x[:user_id]}
		update_users 
		AdminUserUpdateStats.enqueue("User update email sent", admin_stats)
		@updated = nil
		@output = nil
	else
		AdminUserUpdateStats.enqueue("Zero user update emails today", "No updates for usertrackers were found today.")
	end
	erb "<p>Proceed <a href='/'>home</a>?</p>"
end

def find_updates
	updatepool = UserTracker.all
	updatepool.map do |usertracker|
	 	if usertracker.timestamp < Tracker[usertracker.tracker_id].timestamp
	 		@updated << usertracker
		end
	end
	updatepool = nil
end

def update_users
	@output.each do |user, usertrackers|
		@thisuser_update = []
		usertrackers.each do |usertracker|
			@thisuser_update << Tracker[usertracker.tracker_id].keywords
		end
		NewTorrents.enqueue(User[user].email, @thisuser_update)
		usertrackers.each do |usertracker|
			usertracker.timestamp = Tracker[usertracker.tracker_id].timestamp
			usertracker.save
		end
	end
end

def admin_stats
	"#{@updated.count} #{@updated.count == 1 ? "usertracker" : "usertrackers"} #{@updated.count == 1 ? "was" : "were"} updated today for #{@output.count} individual #{@output.count == 1 ? "user" : "users "} ."
end
