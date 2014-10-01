class Contest::Ansable::Fill < ActiveRecord::Base
  has_one :ans, as: :ansable, dependent: :destroy

  structure do
    content ""
  end
end
