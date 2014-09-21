class ManagerTaskSerializer < ActiveModel::Serializer
  root false
  attributes :tid
  has_many :choices, key: "nodes", serializer: MenuSerializer
end
