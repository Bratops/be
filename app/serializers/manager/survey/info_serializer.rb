class Manager::Survey::InfoSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :info, :quests_count
  has_many :quests, serializer: Manager::Survey::QuestSerializer

  def quests_count
    object.quests.count
  end
end
