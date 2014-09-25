class Task::Author < ActiveRecord::Base

  has_many :tasks, class_name: "Task::Auth",
    dependent: :destroy,
    foreign_key: :author_id

  belongs_to :country, class_name: "Task::Country"
  counter_culture :country, column_name: "authors_count"

  structure do
    name ""
    email ""

    tasks_count 0
  end
end
