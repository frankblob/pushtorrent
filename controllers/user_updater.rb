class UserUpdater

	def initialize
		@updated = []
		find_updates
		if !@updated.empty?
			@output = @updated.group_by {|x| x[:user_id]}
			update_users 
			update_admin_userupdates("User update email sent", admin_stats)
			@updated = nil
			@output = nil
		else
			update_admin_userupdates("Zero user update emails today", "No updates for usertrackers were found today.")
		end
	end

	private

	def find_updates
		updatepool = UserTracker.all
		updatepool.map do |usertracker|
		 	if usertracker.timestamp < Tracker[usertracker.tracker_id].timestamp
		 		@updated << usertracker
			end
		end
	end

	def update_users
			@output.each do |user, usertrackers|
				@thisuser_update = []
				usertrackers.each do |usertracker|
					@thisuser_update << Tracker[usertracker.tracker_id].keywords
				end
				new_torrents(User[user].email, @thisuser_update)
				usertrackers.each do |usertracker|
					usertracker.timestamp << Tracker[usertracker.tracker_id].timestamp
				end
			end
		end
	end

	def admin_stats
		"#{@updated.count} #{@updated.count < 2 ? "usertracker " : "usertrackers "} #{@updated.count < 2 ? "was " : "were "} successfully updated today for #{output.count} different users."
	end

end #class end

=begin

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

=end