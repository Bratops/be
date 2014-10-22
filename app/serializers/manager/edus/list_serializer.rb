class Manager::Edus::ListSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name
end
