class KeywordSearch

	URL = 'https://torrentz.eu/feedA?f=' #date-sorted
	#	seeder-sorted = 'https://torrentz.eu/feed?q='
	#URL2 = 'https://kickass.so/usearch/' # also edit results.erb to match kickass output format
	
	def initialize(searchstring)
		@url 	= URL  + searchstring.split(' ').join('+') #+ "/?rss=1" (for kickass.so)
		#@url2 = URL2 + searchstring.split(' ').join('%20') + '/?rss=1'
		@bkupkeywords = searchstring
	end

	def results
		#develop (1-4) fail-safe options, if torrentz.eu is down/blocking/non-responsive
		begin
			Timeout::timeout(0.55) do
				puts "Connecting to Torrentz.eu"
				@data = Nokogiri::XML(open(@url))
			end
		rescue
			url = 'https://kickass.so/usearch/' + @bkupkeywords.split(' ').join('%20') + '/?rss=1'
			puts "Sourcing Kickass..."
			@data = Nokogiri::XML(open(url))
		end	
		@data.xpath('//channel/item')[0..9]#.sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	end

end