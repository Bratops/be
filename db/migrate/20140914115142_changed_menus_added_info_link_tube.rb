class ChangedMenusAddedInfoLinkTube < ActiveRecord::Migration
  def self.up
    add_column :menus, :info_link, :string
    add_column :menus, :tube, :string
  end
  
  def self.down
    remove_column :menus, :info_link
    remove_column :menus, :tube
  end
end
