class Manager::TaskSerializer < ActiveModel::Serializer
  root false
  attributes :tid, :title, :body, :explain, :quest, :info
  attributes :year
  has_many :choices, serializer: Manager::TaskChoiceSerializer

  has_many :klasses, serializer: Manager::TaskTagSerializer
  has_many :opens, serializer: Manager::TaskTagSerializer
  has_many :keywords, serializer: Manager::TaskTagSerializer
  has_many :official_ratings, serializer: Manager::TaskRatingSerializer

  def year
    object.created_at.year
  end

  def tid
    object.id
  end

  def official_ratings
    object.find_votes_for("vote_scope like '%_official%'")
  end
end
