class Survey::Quest < ActiveRecord::Base
  belongs_to :survey, class_name: "Survey::Info"

  has_many :ans, class_name: "Survey::Ans"
  has_many :choices, class_name: "Survey::Choice"

  structure do
    order 0
    content ""
    type 0 # single, multiple

    timestamps
  end
end
