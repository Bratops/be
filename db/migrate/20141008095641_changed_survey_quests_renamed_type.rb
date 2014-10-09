class ChangedSurveyQuestsRenamedType < ActiveRecord::Migration
  def self.up
    rename_column :survey_quests, :type, :qtype
  end
  
  def self.down
    rename_column :survey_quests, :qtype, :type
  end
end
