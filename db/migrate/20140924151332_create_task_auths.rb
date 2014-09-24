class CreateTaskAuths < ActiveRecord::Migration
  def self.up
    create_table :task_auths do |t|
      t.integer :author_id 
      t.integer :task_id 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :task_auths, :author_id
    add_index :task_auths, :task_id
  end
  
  def self.down
    drop_table :task_auths
  end
end
