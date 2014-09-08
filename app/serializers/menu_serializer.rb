class MenuSerializer < ActiveModel::Serializer
  root false

  attributes :name, :pos, :icon, :link, :desc
  attribute :id
  has_many :children, key: "nodes", serializer: MenuSerializer

  def id
    scope[:edit].nil? ? nil : object.id
  end
end
