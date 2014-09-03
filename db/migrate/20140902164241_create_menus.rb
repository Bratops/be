class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.integer :parent_id 
      t.integer :klass 
      t.string :name 
      t.string :desc 
      t.string :icon 
      t.string :link 
      t.integer :pos 
      t.integer :children_count 
      t.integer :lft 
      t.integer :rgt 
      t.integer :depth 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :menus, :parent_id
    add_index :menus, :lft
    add_index :menus, :rgt
  end
  
  def self.down
    drop_table :menus
  end
end
