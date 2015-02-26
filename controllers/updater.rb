class TrackerUpdater
Tracker.plugin :touch
attr_accessor :updated_trackers
attr_reader :updatepool

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
				results = search.results
				#rescue process here, since results can be nil if no releases or nonresponsive feed/site
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