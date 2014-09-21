class ChangedTaskInfosRenamedName < ActiveRecord::Migration
  def self.up
    rename_column :task_infos, :name, :title
  end
  
  def self.down
    rename_column :task_infos, :title, :name
  end
end
