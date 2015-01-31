Sequel::Model.plugin :timestamps, :update_on_create=>true
Sequel::Model.plugin :validation_helpers

require_relative 'user'
require_relative 'tracker'
require_relative 'usertracker'
