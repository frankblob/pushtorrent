get '/' do
	erb :index
end

post '/' do
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').strip
	redirect back if keywords.empty?
	search = KeywordSearch.new(keywords)
	@results = search.results
	if @results.empty?
		erb :zerohits
	else
		@keywords = keywords
		@timestamp = @results[0].at_css('pubDate').text.to_time
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
	puts env['sinatra.error'].name
	erb :four04
end

not_found do
	status 404
	erb :four04
end
