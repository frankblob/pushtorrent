class UserTracker < Sequel::Model

  many_to_one :user
  many_to_one :tracker

  def validate
  	super
    validates_presence [ :user_id, :tracker_id, :timestamp ]
    validates_unique([:user_id, :tracker_id])
  end

end
