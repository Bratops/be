class Contest::ChoiceSerializer < ActiveModel::Serializer
  root false
  cached
  attributes :id, :index, :content
end
