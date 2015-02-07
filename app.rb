require 'sinatra'
require 'sequel'
require 'sequel_secure_password'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/string/conversions'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'awesome_print'  if development?

require_relative 'db/init'
require_relative 'models/init'
require_relative 'controllers/init'

use Rack::Session::Cookie, secret: "FiliBu7SterHankerCH11!Fen"

helpers do
	def current_user?
		session[:user_id]
	end
end

get '/forum/?' do
	erb :forum
end
