class Survey::Ans < ActiveRecord::Base
  has_one :comment, class_name: "Survey::Comment"
  has_many :ans_choices, class_name: "Survey::AnsChoice"

  belongs_to :quest, class_name: "Survey::Quest"
  belongs_to :ans, class_name: "Survey::AnsSet"

  structure do
  end
end
