class CreateContestRegs < ActiveRecord::Migration
  def self.up
    create_table :contest_regs do |t|
      t.integer :contest_id 
      t.integer :ugroup_id 
      t.datetime :exdate 
      t.integer :extime 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :contest_regs, :contest_id
    add_index :contest_regs, :ugroup_id
  end
  
  def self.down
    drop_table :contest_regs
  end
end
