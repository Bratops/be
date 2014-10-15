class Contest::TaskSerializer < ActiveModel::Serializer
  root false
  cached
  attributes :id, :title, :body, :quest, :kind
  attributes :skip, :timespan
  has_many :choices, serializer: Contest::ChoiceSerializer

  def kind
    "single"
  end

  def skip
    0
  end

  def timespan
    0
  end
end
