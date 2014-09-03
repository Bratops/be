class ChangedUsersDeletedXrole < ActiveRecord::Migration
  def self.up
    remove_column :users, :xrole
  end
  
  def self.down
    add_column :users, :xrole, :string, :limit=>255, :default=>nil
  end
end
