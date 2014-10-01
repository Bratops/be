class CreateContestAnsableMultis < ActiveRecord::Migration
  def self.up
    create_table :contest_ansable_multis do |t|
    end
  end
  
  def self.down
    drop_table :contest_ansable_multis
  end
end
