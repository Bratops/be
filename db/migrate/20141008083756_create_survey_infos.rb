class CreateSurveyInfos < ActiveRecord::Migration
  def self.up
    create_table :survey_infos do |t|
      t.integer :contest_id 
      t.string :name 
      t.string :info 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
    add_index :survey_infos, :contest_id
  end
  
  def self.down
    drop_table :survey_infos
  end
end
