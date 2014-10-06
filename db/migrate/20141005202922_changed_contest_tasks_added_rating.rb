class ChangedContestTasksAddedRating < ActiveRecord::Migration
  def self.up
    add_column :contest_tasks, :rating, :integer
  end
  
  def self.down
    remove_column :contest_tasks, :rating
  end
end
