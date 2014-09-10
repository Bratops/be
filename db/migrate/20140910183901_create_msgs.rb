class CreateMsgs < ActiveRecord::Migration
  def self.up
    create_table :msgs do |t|
      t.string :title 
      t.string :body 
      t.datetime :start_time 
      t.datetime :end_time 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :msgs
  end
end
