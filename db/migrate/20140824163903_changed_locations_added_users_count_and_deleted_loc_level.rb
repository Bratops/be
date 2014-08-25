class ChangedLocationsAddedUsersCountAndDeletedLocLevel < ActiveRecord::Migration
  def self.up
    add_column :locations, :users_count, :integer
    remove_column :locations, :loc_level
  end
  
  def self.down
    add_column :locations, :loc_level, :integer, :limit=>nil, :default=>nil
    remove_column :locations, :users_count
  end
end
