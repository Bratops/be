class ChangedTaskInfosAddedContestsCountAndDeletedRegion < ActiveRecord::Migration
  def self.up
    add_column :task_infos, :contests_count, :integer
    remove_column :task_infos, :region
  end
  
  def self.down
    add_column :task_infos, :region, :string, :limit=>255, :default=>nil
    remove_column :task_infos, :contests_count
  end
end
