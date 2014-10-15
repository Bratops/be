class Survey::AnsChoice < ActiveRecord::Base
  has_one :comment, class_name: "Survey::Comment",
    dependent: :destroy

  belongs_to :ans, class_name: "Survey::Ans"
  belongs_to :choice, class_name: "Survey::Choice"

  accepts_nested_attributes_for :comment
  structure do
  end
end
