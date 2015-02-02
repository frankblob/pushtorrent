class Tracker < Sequel::Model
	
  one_to_many :user_trackers
  many_to_many :users, :left_key=>:tracker_id, :right_key=>:user_id,
    :join_table=>:user_trackers

  def validate
    super
    validates_presence [ :keywords, :timestamp ]
  end

  def self.create_or_select(keywords, timestamp)
    # Refactor this :)
    if Tracker[keywords: keywords].nil?
      tracker = Tracker.create(keywords: keywords, timestamp: timestamp)
    else
      tracker = Tracker[keywords: keywords]
    end
  end

end
