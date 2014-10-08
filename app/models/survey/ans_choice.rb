class Survey::AnsChoice < ActiveRecord::Base
  belongs_to :ans, class_name: "Survey::Ans"
  belongs_to :choice, class_name: "Survey::Choice"

  structure do
  end
end
