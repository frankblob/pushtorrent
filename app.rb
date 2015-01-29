require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/string/conversions'
require "sinatra/reloader" if development?

require_relative 'db/init'
require_relative 'models/init'

use Rack::Session::Cookie, secret: "FiliBu7SterHankerCH11!Fen"

helpers do
	def current_user?
		session[:user_id]
	end
end

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

get '/signup/?' do #display signup form
	erb :signup_form
end

post '/signup/?' do #create user
	user = User.new(params[:user])
	if user.save
		redirect to("/user/#{ user.id }") #|| redirect back or:home?
	else 
		redirect '/signup'
	end
end

get '/login/?' do #display login form
	erb :login
end

post '/login/?' do #authenticate user and set session
	redirect '/login' unless user = User.where(email: params[:user][:email]).first
	if BCrypt::Password.new(user.password_digest) == params[:user][:password]
		session[:user_id] = user.id
		redirect "/user/#{session[:user_id]}"
		#env[return_path] (set as attempted path when unauthorized) ? redirect back : '/'
	else
		#session[:user_id] = nil
		redirect '/login'
	end
end

get '/logout/?' do
	session[:user_id] = nil
	redirect '/'
end

get '/user/:id/?' do
	if session[:user_id] == params[:id].to_i
		@user = User.where(id: (params[:id])).first
		usertrackers = UserTracker.where(user_id: (params[:id])).all
		@trackers = usertrackers.map{|x| x.tracker}
		erb :user
	else
		"Nope. Not authorized."
	end
end

get '/trackers/?' do
  "Tracker GET page" #purpose unclear...
end	

post '/trackers/?' do
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
#Tracker added for Equalizer 2014. {"user_id"=>"1", "keywords"=>"Equalizer 2014"} 
	if current_user?
		# split logic depending on user type
		user = User.get(params[:user_id])
		timestamp = params[:timestamp]
		if Tracker[keywords: params[:keywords]].nil?
			tracker = Tracker.create(keywords: params[:keywords], timestamp: params[:timestamp])
		else
			tracker = Tracker[keywords: params[:keywords]]
		end
		user.add_user_tracker(tracker: tracker, timestamp: params[:timestamp])
		erb "Tracker added for #{params[:keywords]}.\n#{params}"
	else
		#ask for email and store as user type 0
		erb "We need your email to notify for new torrents - or you can signup to get 5 trackers."
	end

end

get '/about/?' do
	erb :about
end

get '/contact/?' do
	erb :contact
end

get '/forum/?' do
	erb :forum
end

not_found do
	status 404
	erb :four04, layout: false
end