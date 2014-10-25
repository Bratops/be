class Teacher::ClusterSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name
end
