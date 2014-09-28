class Manager::Contest::TaskSerializer < ActiveModel::Serializer
  root false
  attributes :id, :tid, :title, :year, :rating

  def year
    object.created_at.year
  end

  def rating
    object.vote_weight
  end
end
