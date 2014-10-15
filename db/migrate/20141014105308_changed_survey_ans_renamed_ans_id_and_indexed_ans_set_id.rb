class ChangedSurveyAnsRenamedAnsIdAndIndexedAnsSetId < ActiveRecord::Migration
  def self.up
    rename_column :survey_ans, :ans_id, :ans_set_id
  end
  
  def self.down
    rename_column :survey_ans, :ans_set_id, :ans_id
  end
end
