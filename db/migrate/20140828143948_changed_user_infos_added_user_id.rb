class ChangedUserInfosAddedUserId < ActiveRecord::Migration
  def self.up
    add_column :user_infos, :user_id, :integer
    add_index :user_infos, :user_id
  end
  
  def self.down
    remove_column :user_infos, :user_id
  end
end
