class RenameEdu < ActiveRecord::Migration
  def change
    rename_table :schools, :edu_schools
    rename_table :age_levels, :edu_levels
    rename_table :holders, :edu_holders
    rename_table :locations, :edu_locs
    rename_table :ugroups, :edu_ugroups
  end
end
