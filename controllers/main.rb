get '/' do
	erb :index
end

post '/' do
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').strip
	redirect back if keywords.empty?
	search = KeywordSearch.new(keywords)
	@keywords = search.keywords
	@results = search.results
	@results.empty? ? (erb :zerohits) : (@timestamp = @results[0].at_css('pubDate').text.to_time)
	erb :results
end

get '/about/?' do
	erb :about
end

get '/contact/?' do
	erb :contact
end

not_found do
	status 404
	erb :four04
end
