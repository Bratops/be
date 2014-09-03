class MenuSerializer < ActiveModel::Serializer
  root false
  attributes :name, :pos, :icon, :link, :desc
  has_many :children
end
