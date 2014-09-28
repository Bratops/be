class CreateContestInfos < ActiveRecord::Migration
  def self.up
    create_table :contest_infos do |t|
      t.string :name 
      t.integer :grading 
      t.datetime :sdate 
      t.datetime :edate 
      t.integer :tasks_count 
    end
  end
  
  def self.down
    drop_table :contest_infos
  end
end
