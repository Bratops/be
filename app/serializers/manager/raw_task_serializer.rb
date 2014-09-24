class Manager::RawTaskSerializer < ActiveModel::Serializer
  root false
  attributes :id, :tid, :title, :body, :explain, :quest, :info
  attributes :year

  has_many :choices,  serializer: Manager::TaskChoiceSerializer
  has_many :klasses,  serializer: Manager::TaskTagSerializer
  has_many :opens,    serializer: Manager::TaskTagSerializer
  has_many :keywords, serializer: Manager::TaskTagSerializer
  has_many :ratings,  serializer: Manager::TaskRatingSerializer

  def year
    object.created_at.year
  end

  def choices
    object.choices.order(:index)
  end

  def ratings
    object.find_votes_for("vote_scope like '%_official%'")
  end
end
