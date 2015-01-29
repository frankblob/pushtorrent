class User < Sequel::Model
	plugin :secure_password, include_validations: false
	
	one_to_many :user_trackers
	many_to_many :trackers, join_table: :user_trackers

	def authenticate(unencrypted_password)
  	if BCrypt::Password.new(password_digest) == unencrypted_password
  		return true
  	else
  		return false
  	end
  end

  def self.get(id=nil)
  	User[id: id]
  end 
   
end