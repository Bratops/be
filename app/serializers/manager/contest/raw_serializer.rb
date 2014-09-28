class Manager::Contest::RawSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :grading, :grading_str, :sdate, :edate

  has_many :tasks, serializer: Manager::Contest::TaskSerializer

  def sdate
    object.sdate.strftime("%Y/%m/%d")
  end

  def edate
    object.edate.strftime("%Y/%m/%d")
  end

  def tasks
    object.grading_tasks
  end
end
