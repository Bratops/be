class ChangedUsersAddedAuthenticationTokenLoginAliasNameSuid < ActiveRecord::Migration
  def self.up
    add_column :users, :authentication_token, :string
    add_column :users, :login_alias, :string
    add_column :users, :name, :string
    add_column :users, :suid, :string
    add_index :users, :suid
    add_index :users, :login_alias
    add_index :users, :authentication_token
  end
  
  def self.down
    remove_column :users, :authentication_token
    remove_column :users, :login_alias
    remove_column :users, :name
    remove_column :users, :suid
  end
end
