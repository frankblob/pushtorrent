# Create a new User table with columns of
# id, name, email and password_digest.
DB.create_table :users do 
  primary_key :id
  column :email, :text, :unique=>true
  column :password_digest, :text
  column :name, :text
  column :created_at, :datetime
  column :updated_at, :datetime
end

# Create a new Tracker table with columns of
# id, keywords and timestamp.
DB.create_table :trackers do 
    primary_key :id
    column :keywords, :text, :unique=>true
    column :timestamp, :datetime
    column :created_at, :datetime
    column :updated_at, :datetime
end

DB.create_table :trackers_users do
		primary_key :id
		foreign_key :user_id, :users
		foreign_key :tracker_id, :trackers
end