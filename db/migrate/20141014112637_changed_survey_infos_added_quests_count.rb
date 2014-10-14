class ChangedSurveyInfosAddedQuestsCount < ActiveRecord::Migration
  def self.up
    add_column :survey_infos, :quests_count, :integer
  end
  
  def self.down
    remove_column :survey_infos, :quests_count
  end
end
