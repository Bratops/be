class Manager::TaskChoiceSerializer < ActiveModel::Serializer
  attributes :id, :answer, :content, :index
end
