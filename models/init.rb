Sequel::Model.plugin :timestamps, :update_on_create=>true

require_relative 'user'
require_relative 'tracker'
require_relative 'keyword_search'
