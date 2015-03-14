require 'sinatra'
require 'sinatra/flash'
require 'encrypted_cookie'

unless production? || ENV["RACK_ENV"] == "production"
	require 'awesome_print'
	require 'dotenv'
	Dotenv.load
	require 'rack/ssl-enforcer'
	use Rack::SslEnforcer
end
 
require_relative 'db/init'
require_relative 'models/init'
require_relative 'controllers/init'
    
cookie_config = {        
  :key          => 'usr',
  :path         => "/",
  :expire_after => 86400, # one day in seconds
  :secret       => ENV["COOKIE_KEY"], 
  :httponly     => true
  }
cookie_config.merge!( :secure => true ) if production? || ENV["RACK_ENV"] == "production"

use Rack::Session::EncryptedCookie, cookie_config

helpers do
	def current_user?
		session[:user_id]
	end
end

get '/forum/?' do
	erb :forum
end
