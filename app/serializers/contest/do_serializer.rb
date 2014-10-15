class Contest::DoSerializer < ActiveModel::Serializer
  root false
  cached
  attributes :id, :name, :check_survey
  has_many :tasks, serializer: Contest::TaskSerializer

  def check_survey
    !!object.survey
  end
end
