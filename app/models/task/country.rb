class Task::Country < ActiveRecord::Base

  has_many :authors, class_name: "Task::Author"

  structure do
    name ""

    authors_count 0
  end
end
