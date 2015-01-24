require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
#require 'warden'
#require 'sinatra/flash'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/string/conversions'

#require_relative 'auth/init'

DB = Sequel.connect "sqlite://db/torwa-ar.db"
Sequel::Model.plugin :timestamps, :update_on_create=>true

#use Rack::Session::Cookie, secret: "FiliBu7SterHankerCH11!Fen"

class User < Sequel::Model
	plugin :secure_password, include_validations: false
	
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

get '/signup' do #display signup form
	erb :signup_form
end

post '/signup' do #create user
	user = User.new(params[:user])
	if user.save
		redirect to("/user/#{ user.id }") #|| redirect back or:home?
	else 
		redirect "/signup"
	end
end

get '/user' do #display login form
	erb :login
end

get '/user/:id' do
	@user = User.where(id: (params[:id])).first
	usertrackers = UserTracker.where(user_id: (params[:id])).all
	@trackers = usertrackers.map{|x| x.tracker}
	erb :user
end

get '/trackers' do
  "Tracker GET page" #purpose unclear...
end	

post '/trackers' do
	"Tracker added for #{params[:keywords]}"
	# redirect_back or redirect "/trackers"?
#if current_user does not exists:

#if email does not exist
# display email + torrent notification and settings

#	user = User.new(params[:email])
#	user.save
#	tracker = Tracker.new(params[:keywords])
#	tracker.save #check routine for existing
# usertracker = UserTracker.new(user_id: user.id, tracker_id: tracker.id)
# usertracker.save
#	redirect to("/user/#{ user.id }") #|| redirect back or:home?

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