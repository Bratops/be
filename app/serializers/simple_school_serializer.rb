class SimpleSchoolSerializer < ActiveModel::Serializer
  root false
  attributes :moeid, :name
end
