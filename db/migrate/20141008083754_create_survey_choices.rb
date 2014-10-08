class CreateSurveyChoices < ActiveRecord::Migration
  def self.up
    create_table :survey_choices do |t|
      t.integer :quest_id 
      t.integer :order 
      t.string :content 
      t.boolean :commentable 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :survey_choices, :quest_id
  end
  
  def self.down
    drop_table :survey_choices
  end
end
