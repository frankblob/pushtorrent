class KeywordSearch

	URL = 'https://torrentz.eu/feed?q='

	def initialize(searchstring)
		keywords = searchstring.tr('^-a-zA-z0-9_.', ' ')
		@keywords = keywords
		@url = URL + keywords.split(' ').join('+')
	end

	def keywords
		@keywords
	end

	def results
		#develop (1-4) fail-safe options, if torrentz.eu is down/blocking/non-responsive
		data = Nokogiri::XML(open(@url))
		data.xpath('//channel/item').sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	end

end