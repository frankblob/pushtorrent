class Tracker < Sequel::Model
	one_to_many :user_trackers
	many_to_many :users, join_table: :user_trackers

  def self.get(id=nil)
  	Tracker[id: id]
  end

end