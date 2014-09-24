class CreateTaskAuthors < ActiveRecord::Migration
  def self.up
    create_table :task_authors do |t|
      t.integer :country_id 
      t.string :name 
      t.string :email 
      t.integer :tasks_count 
    end
    add_index :task_authors, :country_id
  end
  
  def self.down
    drop_table :task_authors
  end
end
