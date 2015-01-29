DB = Sequel.connect "sqlite://db/torwa-alt.db"

if !DB[:users]
	require_relative 'createdb.rb'
end
