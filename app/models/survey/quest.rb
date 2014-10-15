class Survey::Quest < ActiveRecord::Base
  belongs_to :survey, class_name: "Survey::Info"
  counter_culture :survey, column_name: "quests_count"

  has_many :ans, class_name: "Survey::Ans",
    foreign_key: :ans_set_id, dependent: :destroy

  has_many :choices, class_name: "Survey::Choice",
    foreign_key: :quest_id, dependent: :destroy

  accepts_nested_attributes_for :choices, allow_destroy: true

  structure do
    order 0
    content ""
    qtype 0 # single, multiple

    timestamps
  end
end
