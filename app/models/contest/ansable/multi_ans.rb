class Contest::Ansable::MultiAns < ActiveRecord::Base
  belongs_to :multi, class_name: "Contest::Ansable::Multi"
  belongs_to :choice, class_name: "Task::Choice"

  structure do
  end
end
