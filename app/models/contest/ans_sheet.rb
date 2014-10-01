class Contest::AnsSheet < ActiveRecord::Base
  has_many :answers, class_name: "Contest::Ans",
    dependent: :destroy,
    foreign_key: :summary_id

  belongs_to :user
  belongs_to :ugroup, class_name: "Edu::Ugroup"
  belongs_to :contest, class_name: "Contest::Info"

  structure do
    score 0
    pr 0
    timespan 0

    ans_count 0

    timestamps
  end
end
