class TaskSerializer < ActiveModel::Serializer
  cached
  root false
  attributes :tid, :name, :body, :quest, :year

  def year
    object.created_at.year
  end

  def cache_key
    [object, scope]
  end
end
