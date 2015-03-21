require 'sequel'
require 'sequel_secure_password'
require 'logger'	

Sequel.default_timezone = :utc
DB = Sequel.connect ENV['DATABASE_URL'], :loggers => [Logger.new($stdout)]
require_relative 'createdb.rb' unless DB.table_exists?(:users)

require 'que'
Que.connection = DB
Que.migrate! unless DB.table_exists?(:que_jobs)