require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/string/conversions'

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
	#develop (1-4) fail-safe options, if torrentz.eu is down/blocking/non-responsive
	url = 'https://torrentz.eu/feed?q=' + keywords
	@keywords = keywords.split('+').join(' ')
	data = Nokogiri::XML(open(url))
	@items = data.xpath('//channel/item').sort_by{|x| x.at_css('pubDate').text.to_time}.reverse
	@items.empty? ? (erb :zerohits) : (erb :results)
end

get '/login' do # display login form
	erb :login
end

post '/login' do
	#create user session
	redirect_back
end

get '/signup' do # display signup form
	@user = User.new
	erb :signup #redirect signup-confirmation, back, home or user?
end

post '/signup' do #create user
	erb :signup_confirm #|| redirect :back, :home or :user?
end

get '/user/:id' do
	#if user == logged in
	@user = User.where(id: (params[:id])).first
	usertrackers = UserTracker.where(user_id: (params[:id])).all
	@trackers = usertrackers.map{|x| x.tracker}
	erb :user
	#if user != logged in
	#erb :login
	#erb :loginorsignup / :access
end

post '/tracker' do
#if current_user does not exists:

#if email does not exist
# display email + torrent notification and settings

#if email does exist, with user_type = 0
#display current tracker, offer to replace and to signup

#if email does exist, with user_type = 1 || 2
#display login page

#if current_user exists:
#add and display added + highlighted tracker in user's tracker list

end

get '/about' do
	erb :about
end

get '/contact' do
	erb :contact
end

get '/forum' do
	erb :forum
end

not_found do
	status 404
	erb :four04, layout: false
end