class ChangedEduUgroupsAddedRegsCount < ActiveRecord::Migration
  def self.up
    add_column :edu_ugroups, :regs_count, :integer
  end
  
  def self.down
    remove_column :edu_ugroups, :regs_count
  end
end
