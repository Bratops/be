class CreateUgroups < ActiveRecord::Migration
  def self.up
    create_table :ugroups do |t|
      t.integer :school_id 
      t.string :name 
      t.integer :group_type 
      t.integer :enrollments_count 
      t.integer :users_count 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :ugroups, :school_id
  end
  
  def self.down
    drop_table :ugroups
  end
end
