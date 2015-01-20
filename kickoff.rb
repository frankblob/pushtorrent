require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext/string/conversions'

get '/' do
	erb :search
end

post '/' do
	redirect back if params[:keywords].empty?
	keywords = params[:keywords].tr('^-a-zA-z0-9_.', ' ').split(' ').join('+')
	url = 'https://torrentz.eu/feed?q=' + keywords
	@keywords = keywords.split('+').join(' ')
	data = Nokogiri::XML(open(url))
	@items = data.xpath('//channel/item').sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	@items.empty? ? (erb :zerohits) : (erb :results)
end

get '/user' do
	erb :login
end

post '/user' do
	erb :userpage
end

get '/about' do
	erb :about
end

get '/contact' do
	erb :contact
end

get '/signup' do
	erb :signup
end

get '/forum' do
	erb :forum
end

not_found do
	status 404
	erb :four04, layout: false
end