class ChangedSurveyInfosDeletedContestId < ActiveRecord::Migration
  def self.up
    remove_column :survey_infos, :contest_id
  end
  
  def self.down
    add_column :survey_infos, :contest_id, :integer, :limit=>nil, :default=>nil
  end
end
