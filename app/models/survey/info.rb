class Survey::Info < ActiveRecord::Base
  has_many :quests, class_name: "Survey::Quest"
  has_many :ans_sets, class_name: "Survey::AnsSet"
  has_many :ans, class_name: "Survey::Ans", through: :ans_sets

  belongs_to :contest, class_name: "Contest::Info"

  structure do
    name "new contest", validates: [:presence]
    info ""

    timestamps
  end
end
