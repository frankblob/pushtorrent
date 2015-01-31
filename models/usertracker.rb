class UserTracker < Sequel::Model

  many_to_one :user
  many_to_one :tracker

  def validate
    validates_presence [ :user_id, :tracker_id, :timestamp ]
  end

end
