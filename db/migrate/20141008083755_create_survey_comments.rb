class CreateSurveyComments < ActiveRecord::Migration
  def self.up
    create_table :survey_comments do |t|
      t.integer :ans_id 
      t.string :content 
    end
    add_index :survey_comments, :ans_id
  end
  
  def self.down
    drop_table :survey_comments
  end
end
