class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.integer :user_id 
      t.integer :group_id 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :enrollments, :user_id
    add_index :enrollments, :group_id
  end
  
  def self.down
    drop_table :enrollments
  end
end
