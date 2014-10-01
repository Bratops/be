class Contest::DoSerializer < ActiveModel::Serializer
  root false
  cached
  attributes :id, :name
  has_many :tasks, serializer: User::Contest::TaskSerializer
end
