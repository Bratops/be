class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name 
      t.text :body 
      t.text :quest 
      t.text :explain 
      t.text :info 
      t.text :link 
      t.string :region 
      t.string :tid 
      t.integer :old_id 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :tasks
  end
end
