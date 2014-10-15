class Survey::InfoSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :info
  has_many :quests, serializer: Survey::QuestSerializer
end
