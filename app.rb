require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
require 'nokogiri'
require 'open-uri'

DB = Sequel.connect "sqlite://db/torwa-ar.db"
Sequel::Model.plugin :timestamps, :update_on_create=>true

class User < Sequel::Model
	plugin :secure_password
	
	one_to_many :user_trackers
	many_to_many :trackers, join_table: :user_trackers
end

class UserTracker < Sequel::Model
	many_to_one :user
	many_to_one :tracker
end

class Tracker < Sequel::Model
		one_to_many :user_trackers
		many_to_many :users, join_table: :user_trackers
end

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