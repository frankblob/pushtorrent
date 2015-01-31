DB = Sequel.connect "sqlite://db/torwa-alt.db"

require_relative 'createdb.rb' unless DB.table_exists?(:users)
