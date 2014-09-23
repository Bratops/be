class ChangedEduSchoolsRenamedLocationIdAgeLevelIdAndIndexedLevelIdLocId < ActiveRecord::Migration
  def self.up
    rename_column :edu_schools, :location_id, :loc_id
    rename_column :edu_schools, :age_level_id, :level_id
  end

  def self.down
    rename_column :edu_schools, :loc_id, :location_id
    rename_column :edu_schools, :level_id, :age_level_id
  end
end
