class KeywordSearch

	#	seeder-sorted URL = 'https://torrentz.eu/feed?q='
	# date-sorted URL = 'https://kickass.so/usearch/KEYWORDS/?rss=1'
	URL = 'https://torrentz.eu/feedA?f=' #date-sorted

	def initialize(searchstring)
	#	keywords = searchstring.tr('^-a-zA-z0-9_.', ' ')
		@keywords = searchstring
		@url = URL + keywords.split(' ').join('+') #+ "/?rss=1" (for kickass.so)	
	end

	def keywords
		@keywords
	end

	def results
		#develop (1-4) fail-safe options, if torrentz.eu is down/blocking/non-responsive
		data = Nokogiri::XML(open(@url))
		data.xpath('//channel/item')#[0..9]#.sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	end

end