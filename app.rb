require 'sinatra'
require 'sinatra/flash'

unless ENV["RACK_ENV"] == "production"
	require 'dotenv'
	require 'awesome_print'
	Dotenv.load
end
 
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
