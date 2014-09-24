class CreateTaskCountries < ActiveRecord::Migration
  def self.up
    create_table :task_countries do |t|
      t.string :name 
      t.integer :authors_count 
    end
  end
  
  def self.down
    drop_table :task_countries
  end
end
