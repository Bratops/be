class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name 
      t.integer :loc_level 
      t.integer :groups_count, :null=>false 
      t.integer :schools_count, :null=>false 
    end
  end
  
  def self.down
    drop_table :locations
  end
end
