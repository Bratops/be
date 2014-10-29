class ChangedContestInfosAddedRegsCount < ActiveRecord::Migration
  def self.up
    add_column :contest_infos, :regs_count, :integer
  end
  
  def self.down
    remove_column :contest_infos, :regs_count
  end
end
