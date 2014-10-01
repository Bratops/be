class Contest::Ansable::Multi < ActiveRecord::Base
  has_one :ans, as: :ansable, dependent: :destroy
  has_many :choices, class_name: "Contest::Ansable::MultiAns",
    dependent: :destroy,
    foreign_key: :multi_id

  structure do
  end
end
