class ChangedContestInfosAddedCreatedAtUpdatedAt < ActiveRecord::Migration
  def self.up
    add_column :contest_infos, :created_at, :datetime
    add_column :contest_infos, :updated_at, :datetime
  end
  
  def self.down
    remove_column :contest_infos, :created_at
    remove_column :contest_infos, :updated_at
  end
end
