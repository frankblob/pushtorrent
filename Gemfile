source "https://rubygems.org"

gem "sinatra"
gem "sequel" 
gem "sequel_secure_password"
gem "oga"

gem "logger" # necessary?
gem "sinatra-flash"
require "active_support/core_ext/string/conversions"

require "open-uri" #for nokogiri only?
gem "nokogiri"
require "net/smtp" # necessary, when upgrading to third-party mail service?

group :production do
	gem "pg"
end

group :development do
	gem "thin"
	gem "sqlite3"
end
