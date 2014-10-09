class Manager::Survey::QuestSerializer < ActiveModel::Serializer
  root false
  attributes :id, :order, :content, :qtype
  has_many :choices, serializer: ChoiceSerializer
end
