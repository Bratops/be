class Survey::Info < ActiveRecord::Base
  has_many :quests, class_name: "Survey::Quest",
    foreign_key: :survey_id, dependent: :destroy

  has_many :ans_sets, class_name: "Survey::AnsSet"
  has_many :ans, class_name: "Survey::Ans", through: :ans_sets

  has_many :contest, class_name: "Contest::Info",
    foreign_key: "survey_id"

  accepts_nested_attributes_for :quests, allow_destroy: true

  structure do
    name "new contest", validates: [:presence]
    info ""

    quests_count 0
    timestamps
  end
end
