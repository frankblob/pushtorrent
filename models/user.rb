class User < Sequel::Model

	one_to_many :user_trackers
  many_to_many :trackers, :left_key=>:user_id, :right_key=>:tracker_id,
    :join_table=>:user_trackers

  plugin :secure_password, include_validations: false

  def validate
    validates_presence :email
    validates_min_length 5, :email #i@.to
  end

  def self.get(id=nil)
  	User[id: id]
  end 

end
