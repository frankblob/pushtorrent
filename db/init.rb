require 'logger'
DB = Sequel.connect ENV['DATABASE_URL'] || 'sqlite://db/torwa-alt.db', :loggers => [Logger.new($stdout)]

require_relative 'createdb.rb' unless DB.table_exists?(:users)
