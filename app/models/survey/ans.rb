class Survey::Ans < ActiveRecord::Base
  has_one :comment, class_name: "Survey::Comment"
  has_many :ans_choices, class_name: "Survey::AnsChoice"

  belongs_to :quest, class_name: "Survey::Quest"

  belongs_to :ans_set, class_name: "Survey::AnsSet"
  counter_culture :ans_set, column_name: "ans_count"

  structure do
  end
end
