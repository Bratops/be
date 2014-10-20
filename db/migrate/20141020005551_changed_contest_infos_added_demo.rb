class ChangedContestInfosAddedDemo < ActiveRecord::Migration
  def self.up
    add_column :contest_infos, :demo, :boolean
  end
  
  def self.down
    remove_column :contest_infos, :demo
  end
end
