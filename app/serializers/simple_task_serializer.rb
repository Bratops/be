class SimpleTaskSerializer < ActiveModel::Serializer
  root false
  attributes :task_id

  def task_id
    "#{year}-#{object.region}-#{object.tid}"
  end

  def year
    object.created_at.year
  end
end
