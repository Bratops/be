class ChangedTaskInfosIndexedTid < ActiveRecord::Migration
  def self.up
    add_index :task_infos, :tid
  end
  
  def self.down
  end
end
