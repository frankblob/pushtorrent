get '/' do
	erb :index
end

post '/' do
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').strip
	redirect back if keywords.empty?
	search = KeywordSearch.new(keywords)
	@results = search.results
	if @results.empty?
		@keywords = keywords
		erb :zerohits
	else
		@keywords = keywords
		@timestamp = Time.parse(@results[0].at_css('pubDate').text)
		erb :results
	end
end

get '/about/?' do
	erb :about
end

get '/contact/?' do
	erb :contact
end

error do
	status 500
	erb :four04
end

not_found do
	status 404
	erb :four04
end
