get '/twenty4hrupdater-first' do
	updater = TrackerUpdater.new
	mailcontent = updater.updated_trackers.map do |t|
									Tracker[t].keywords
								end
	update_admin(mailcontent)
	updater = nil
end

class TrackerUpdater
Tracker.plugin :touch
attr_reader :updatepool, :updated_trackers

	def initialize
		@updated_trackers = []
		@updatepool = Tracker.where{updated_at < Time.now-86400}.all || []
		go!
	end

private
		
	def go!	
		if @updatepool.empty?
			@updated_trackers = []
		else
			@updatepool.each do |tracker|
				search = KeywordSearch.new(tracker.keywords)
				results = search.results || []
				if !results.empty? #results can be nil if no releases or nonresponsive feed
					timestamp = results[0].at_css('pubDate').text.to_time
					if timestamp > tracker.timestamp
						tracker.timestamp = timestamp
						tracker.save
						@updated_trackers << tracker.id
						#sleep 3 #to avoid ban for hammering feed source?
					else
						tracker.touch #why? To show it has been processed, but leave timestamp
					end
				end
			end
		end
	end

end