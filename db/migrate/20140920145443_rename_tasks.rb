class RenameTasks < ActiveRecord::Migration
  def change
    rename_table :tasks, :task_infos
  end
end
