class Manager::Survey::ListSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name
end
