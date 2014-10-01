class CreateContestAnsableSingles < ActiveRecord::Migration
  def self.up
    create_table :contest_ansable_singles do |t|
      t.integer :choice_id 
    end
    add_index :contest_ansable_singles, :choice_id
  end
  
  def self.down
    drop_table :contest_ansable_singles
  end
end
