class ChangedMenusModifiedKlass < ActiveRecord::Migration
  def self.up
    change_column :menus, :klass, :string
  end
  
  def self.down
    change_column :menus, :klass, :integer, :limit=>nil, :default=>nil
  end
end
