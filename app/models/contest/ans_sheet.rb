class Contest::AnsSheet < ActiveRecord::Base
  include Concerns::Contest::Score
  has_many :answers, class_name: "Contest::Ans",
    dependent: :destroy,
    foreign_key: :ans_sheet_id

  belongs_to :user
  belongs_to :ugroup, class_name: "Edu::Ugroup"
  belongs_to :contest, class_name: "Contest::Info"

  def self.do_by_user user
    where(user: user, score: -1)
  end

  structure do
    score 0
    pr 0
    skips 0
    timespan 0

    ans_count 0

    timestamps
  end
end
