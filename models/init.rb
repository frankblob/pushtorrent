Sequel::Model.plugin :timestamps, :update_on_create=>true
Sequel::Model.plugin :validation_helpers

#Sequel::Model.plugin(:auto_validations)
#Sequel::Model.plugin(:constraint_validations)

require_relative 'user'
require_relative 'tracker'
require_relative 'usertracker'
