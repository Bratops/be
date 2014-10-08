class CreateSurveyAns < ActiveRecord::Migration
  def self.up
    create_table :survey_ans do |t|
      t.integer :quest_id 
      t.integer :ans_id 
    end
    add_index :survey_ans, :quest_id
    add_index :survey_ans, :ans_id
  end
  
  def self.down
    drop_table :survey_ans
  end
end
