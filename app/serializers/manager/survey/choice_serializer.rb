class Manager::Survey::ChoiceSerializer < ActiveModel::Serializer
  root false
  attributes :id, :order, :content, :commentable
end
