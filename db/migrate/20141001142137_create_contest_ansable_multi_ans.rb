class CreateContestAnsableMultiAns < ActiveRecord::Migration
  def self.up
    create_table :contest_ansable_multi_ans do |t|
      t.integer :multi_id 
      t.integer :choice_id 
    end
    add_index :contest_ansable_multi_ans, :multi_id
    add_index :contest_ansable_multi_ans, :choice_id
  end
  
  def self.down
    drop_table :contest_ansable_multi_ans
  end
end
