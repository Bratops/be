class ChangedContestInfosAddedSurveyId < ActiveRecord::Migration
  def self.up
    add_column :contest_infos, :survey_id, :integer
    add_index :contest_infos, :survey_id
  end
  
  def self.down
    remove_column :contest_infos, :survey_id
  end
end
