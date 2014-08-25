class ChangedSchoolsAddedAgeLevelIdHolderIdUsersCount < ActiveRecord::Migration
  def self.up
    add_column :schools, :age_level_id, :integer
    add_column :schools, :holder_id, :integer
    add_column :schools, :users_count, :integer
    add_index :schools, :holder_id
    add_index :schools, :age_level_id
  end
  
  def self.down
    remove_column :schools, :age_level_id
    remove_column :schools, :holder_id
    remove_column :schools, :users_count
  end
end
