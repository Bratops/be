class CreateSurveyAnsChoices < ActiveRecord::Migration
  def self.up
    create_table :survey_ans_choices do |t|
      t.integer :ans_id 
      t.integer :choice_id 
    end
    add_index :survey_ans_choices, :ans_id
    add_index :survey_ans_choices, :choice_id
  end
  
  def self.down
    drop_table :survey_ans_choices
  end
end
