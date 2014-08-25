class CreateHolders < ActiveRecord::Migration
  def self.up
    create_table :holders do |t|
      t.string :name 
      t.integer :schools_count 
      t.integer :groups_count 
      t.integer :users_count 
    end
  end
  
  def self.down
    drop_table :holders
  end
end
