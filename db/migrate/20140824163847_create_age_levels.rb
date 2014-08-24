class CreateAgeLevels < ActiveRecord::Migration
  def self.up
    create_table :age_levels do |t|
      t.string :name 
      t.integer :schools_count 
      t.integer :groups_count 
      t.integer :users_count 
    end
  end
  
  def self.down
    drop_table :age_levels
  end
end
