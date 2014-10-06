class ChangedContestAnsAddedCreatedAtUpdatedAtAndDeletedTimeStamps < ActiveRecord::Migration
  def self.up
    add_column :contest_ans, :created_at, :datetime
    add_column :contest_ans, :updated_at, :datetime
    remove_column :contest_ans, :time_stamps
  end
  
  def self.down
    add_column :contest_ans, :time_stamps, :string, :limit=>255, :default=>nil
    remove_column :contest_ans, :created_at
    remove_column :contest_ans, :updated_at
  end
end
