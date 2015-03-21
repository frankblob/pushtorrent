get '/twenty4hrupdater-first/?' do
	DB.transaction do
		TrackerUpdater.enqueue
	end
	erb "<h3>Success!</h3><p>All done, went well.</p>Proceed with <a href='/twenty4hruserupdate-second'>next step</a> or return <a href='/'>home</a>?"
end

class TrackerUpdater < Que::Job
	Tracker.plugin :touch
	attr_reader :updatepool, :updated_trackers

	def run
		@updated_trackers = []
		@updatepool = Tracker.where{updated_at < Time.now-82800}.all || []
		DB.transaction do
		  mailcontent = go!
		  destroy
		  DB.transaction do
	  		UpdateAdmin.enqueue(mailcontent)
			end
		end
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
					timestamp = Time.parse(results[0].at_css('pubDate').text)
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
		@updated_trackers.map { |t| Tracker[t].keywords }
	end

end