class ChangedSurveyAnsSetsAddedAnsCountContestAnsSheetId < ActiveRecord::Migration
  def self.up
    add_column :survey_ans_sets, :ans_count, :integer
    add_column :survey_ans_sets, :contest_ans_sheet_id, :integer
    add_index :survey_ans_sets, :contest_ans_sheet_id
  end
  
  def self.down
    remove_column :survey_ans_sets, :ans_count
    remove_column :survey_ans_sets, :contest_ans_sheet_id
  end
end
