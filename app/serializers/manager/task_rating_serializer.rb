class Manager::TaskRatingSerializer < ActiveModel::Serializer
  attributes :key, :value

  def key
    object.vote_scope.split("_")[0]
  end

  def value
    object.vote_weight
  end
end
