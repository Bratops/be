class ChangedTasksAddedOldIdTidAndDeletedYear < ActiveRecord::Migration
  def self.up
    add_column :tasks, :old_id, :integer
    add_column :tasks, :tid, :string
    remove_column :tasks, :year
  end
  
  def self.down
    add_column :tasks, :year, :integer, :limit=>nil, :default=>nil
    remove_column :tasks, :old_id
    remove_column :tasks, :tid
  end
end
