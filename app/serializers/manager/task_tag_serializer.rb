class Manager::TaskTagSerializer < ActiveModel::Serializer
  attributes :id, :text, :taggings_count

  def text
    object.name
  end
end
