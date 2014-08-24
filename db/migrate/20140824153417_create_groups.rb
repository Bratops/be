class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name 
      t.integer :group_type 
      t.integer :year 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :groups
  end
end
