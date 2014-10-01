class CreateContestAnsSheets < ActiveRecord::Migration
  def self.up
    create_table :contest_ans_sheets do |t|
      t.integer :user_id 
      t.integer :ugroup_id 
      t.integer :contest_id 
      t.integer :score 
      t.integer :pr 
      t.integer :timespan 
      t.integer :ans_count 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :contest_ans_sheets, :user_id
    add_index :contest_ans_sheets, :ugroup_id
    add_index :contest_ans_sheets, :contest_id
  end
  
  def self.down
    drop_table :contest_ans_sheets
  end
end
