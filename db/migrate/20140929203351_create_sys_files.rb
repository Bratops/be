class CreateSysFiles < ActiveRecord::Migration
  def self.up
    create_table :sys_files do |t|
      t.string :name 
      t.string :share 
      t.string :fcode 
      t.integer :down_count 
    end
  end
  
  def self.down
    drop_table :sys_files
  end
end
