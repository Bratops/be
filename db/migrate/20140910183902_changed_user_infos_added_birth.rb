class ChangedUserInfosAddedBirth < ActiveRecord::Migration
  def self.up
    add_column :user_infos, :birth, :datetime
  end
  
  def self.down
    remove_column :user_infos, :birth
  end
end
