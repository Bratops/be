class User::Survey::QuestSerializer < ActiveModel::Serializer
  root false
  attributes :id, :order, :content, :qtype
  has_many :choices, serializer: User::Survey::ChoiceSerializer
end
