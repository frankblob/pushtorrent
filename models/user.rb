class User < Sequel::Model

	one_to_many :user_trackers
  many_to_many :trackers, :left_key=>:user_id, :right_key=>:tracker_id,
    :join_table=>:user_trackers

  plugin :secure_password, include_validations: false

  def validate
    super
    validates_presence :email
    validates_min_length 5, :email #i@.to
    validates_format /.+@.+\..+/i, :email, :message=>'does not seem to be a valid email'
  end

  def self.get(id=nil)
  	User[id: id]
  end 

end
