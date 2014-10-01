class CreateContestAns < ActiveRecord::Migration
  def self.up
    create_table :contest_ans do |t|
      t.integer :ans_sheet_id 
      t.integer :task_id 
      t.string :ansable_type 
      t.integer :ansable_id 
      t.integer :status 
      t.integer :skip 
      t.integer :timespan 
      t.string :time_stamps 
    end
    add_index :contest_ans, :ans_sheet_id
    add_index :contest_ans, :task_id
    add_index :contest_ans, [:ansable_type, :ansable_id]
    add_index :contest_ans, :ansable_id
  end
  
  def self.down
    drop_table :contest_ans
  end
end
