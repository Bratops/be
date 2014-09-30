class User::ContestInfoSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :task_count, :score

  def task_count

  end

  def score
  end
end
