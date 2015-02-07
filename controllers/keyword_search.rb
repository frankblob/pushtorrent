class KeywordSearch

	URL = 'https://torrentz.eu/feedA?f=' #date-sorted
	#	seeder-sorted = 'https://torrentz.eu/feed?q='
	
	def initialize(searchstring)
		@url 	= URL  + searchstring.split(' ').join('%20')
	end

	def results
		begin
			Timeout::timeout(0.55) do
				@data = Nokogiri::XML(open(@url))
			end
			print "Connect #1: torrentz\t"
		rescue
			url = 'https://kickass.so/usearch/' + @url[/(?<==).*/] + '/?rss=1'
			puts "#2 switch: kickass"
			@data = Nokogiri::XML(open(url))
		end	
		@data.xpath('//channel/item')[0..9]#.sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	end

end