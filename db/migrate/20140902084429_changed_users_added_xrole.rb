class ChangedUsersAddedXrole < ActiveRecord::Migration
  def self.up
    add_column :users, :xrole, :string
  end
  
  def self.down
    remove_column :users, :xrole
  end
end
