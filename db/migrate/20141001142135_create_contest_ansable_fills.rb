class CreateContestAnsableFills < ActiveRecord::Migration
  def self.up
    create_table :contest_ansable_fills do |t|
      t.string :content 
    end
  end
  
  def self.down
    drop_table :contest_ansable_fills
  end
end
