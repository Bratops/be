class CreateSurveyQuests < ActiveRecord::Migration
  def self.up
    create_table :survey_quests do |t|
      t.integer :survey_id 
      t.integer :order 
      t.string :content 
      t.integer :type 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :survey_quests, :survey_id
  end
  
  def self.down
    drop_table :survey_quests
  end
end
