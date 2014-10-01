class Contest::InfSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :task_count, :score

  def task_count
    object.tasks_count
  end

  def score
    object.score
  end
end
