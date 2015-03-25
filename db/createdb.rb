DB.extension(:constraint_validations)
DB.create_constraint_validations_table

#uncomment model/init.rb to enable auto-sync with DB contraints

# Create a new User table with columns of
# id, name, email and password_digest.
DB.create_table :users do 
  primary_key :id, Integer
  column :email, String, null: false
  column :password_digest, String
  column :name, String
  column :type, String, :default=>"1", null: false
  column :created_at, DateTime
  column :updated_at, DateTime
  index :email, :unique=>true
  validate do
    presence :email
    min_length 5, :email
    format /.+@.+\..+/i, :email
    format /^[012]/, :type #0,1 or 2; non-registered, registered or paying/premium
  end
end

DB.create_table :trackers do 
  primary_key :id
  column :keywords, String, null: false
  column :timestamp, DateTime, null: false
  column :created_at, DateTime
  column :updated_at, DateTime
  index :keywords, :unique=>true
  index :timestamp
  validate do
    presence :keywords
    presence :timestamp
  end
end

DB.create_table :user_trackers do
    foreign_key :user_id, :users, null: false
    foreign_key :tracker_id, :trackers, null: false
    primary_key [:user_id, :tracker_id], :unique=>true
    column :timestamp, DateTime, null: false
    column :created_at, DateTime
    column :updated_at, DateTime
end
