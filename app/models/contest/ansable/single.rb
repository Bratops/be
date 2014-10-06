class Contest::Ansable::Single < ActiveRecord::Base
  has_one :ans, as: :ansable
  belongs_to :choice, class_name: "Task::Choice"

  structure do
  end
end
