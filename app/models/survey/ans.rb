class Survey::Ans < ActiveRecord::Base
  has_many :ans_choices, class_name: "Survey::AnsChoice",
    dependent: :destroy

  belongs_to :quest, class_name: "Survey::Quest"

  belongs_to :ans_set, class_name: "Survey::AnsSet"
  counter_culture :ans_set, column_name: "ans_count"

  accepts_nested_attributes_for :ans_choices

  structure do
  end
end
