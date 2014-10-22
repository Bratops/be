class Manager::Edus::LocSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name
  has_many :items, serializer: Manager::Edus::SchoolSerializer

  def items
    object.schools
  end
end
