class CreateContestTasks < ActiveRecord::Migration
  def self.up
    create_table :contest_tasks do |t|
      t.integer :task_id 
      t.integer :contest_id 
    end
    add_index :contest_tasks, :task_id
    add_index :contest_tasks, :contest_id
  end
  
  def self.down
    drop_table :contest_tasks
  end
end
