class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name 
      t.string :body 
      t.string :quest 
      t.string :explain 
      t.string :info 
      t.string :link 
      t.string :region 
      t.integer :year 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :tasks
  end
end
