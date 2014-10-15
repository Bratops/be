class ChangedSurveyCommentsRenamedAnsIdAndIndexedAnsChoiceId < ActiveRecord::Migration
  def self.up
    rename_column :survey_comments, :ans_id, :ans_choice_id
  end
  
  def self.down
    rename_column :survey_comments, :ans_choice_id, :ans_id
  end
end
