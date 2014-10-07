class ChangedContestAnsSheetsAddedSkips < ActiveRecord::Migration
  def self.up
    add_column :contest_ans_sheets, :skips, :integer
  end
  
  def self.down
    remove_column :contest_ans_sheets, :skips
  end
end
