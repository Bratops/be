class Contest::TaskSerializer < ActiveModel::Serializer
  root false
  cached
  attributes :tid, :title, :body, :quest
  has_many :choices, serializer: User::Contest::ChoiceSerializer
end
