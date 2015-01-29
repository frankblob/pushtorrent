require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/string/conversions'
require "sinatra/reloader" if development?

require_relative 'db/init'
require_relative 'models/init'
require_relative 'controllers/init'

use Rack::Session::Cookie, secret: "FiliBu7SterHankerCH11!Fen"

helpers do
	def current_user?
		session[:user_id]
	end
end

# Routes

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

get '/forum/?' do
	erb :forum
end
