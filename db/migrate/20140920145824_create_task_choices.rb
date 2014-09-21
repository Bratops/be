class CreateTaskChoices < ActiveRecord::Migration
  def self.up
    create_table :task_choices do |t|
      t.string :content 
    end
  end
  
  def self.down
    drop_table :task_choices
  end
end
