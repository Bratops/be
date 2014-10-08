class Survey::Choice < ActiveRecord::Base
  belongs_to :quest, class_name: "Survey::Quest"

  has_many :ans_choices, class_name: "Survey::AnsChoice"
  has_many :ans, class_name: "Survey::Ans", through: :ans_choices

  structure do
    order 0
    content ""
    commentable false

    timestamps
  end
end
