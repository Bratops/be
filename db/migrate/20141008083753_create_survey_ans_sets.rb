class CreateSurveyAnsSets < ActiveRecord::Migration
  def self.up
    create_table :survey_ans_sets do |t|
      t.integer :survey_id 
      t.integer :user_id 
    end
    add_index :survey_ans_sets, :survey_id
    add_index :survey_ans_sets, :user_id
  end
  
  def self.down
    drop_table :survey_ans_sets
  end
end
