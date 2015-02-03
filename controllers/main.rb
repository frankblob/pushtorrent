get '/' do
	erb :search
end

post '/' do
	redirect back if params[:keywords].empty?
	search = KeywordSearch.new(params[:keywords])
	@keywords = search.keywords
	@results = search.results
	@results.empty? ? (erb :zerohits) : (erb :results)
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
